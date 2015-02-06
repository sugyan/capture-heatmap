require 'rintel'

namespace :import_log do
  desc "import captured log from Intel Map"

  task :worker do
    logger = Logger.new(STDERR)
    client = Rintel::Client.new(
      ENV['GOOGLE_USERNAME'],
      ENV['GOOGLE_PASSWORD'],
      true,
    )

    loop do
      options = {
        "minLatE6" => ENV['MIN_LAT_E6'].to_i,
        "minLngE6" => ENV['MIN_LNG_E6'].to_i,
        "maxLatE6" => ENV['MAX_LAT_E6'].to_i,
        "maxLngE6" => ENV['MAX_LNG_E6'].to_i,
      }
      results = client.plexts("all", options)
      break if results.length == 0

      results.each do |result|
        logger.debug '%s - %s' % [Time.at(result[1] / 1e3), result[2]["plext"]["text"]]

        # captured logs?
        captured = result[2]["plext"]["markup"].any? do |e|
          e[0] == "TEXT" && e[1]["plain"].match(/captured/)
        end
        next unless captured

        # portal
        p = result[2]["plext"]["markup"].find do |e|
          e[0] == "PORTAL"
        end
        portal = Portal.where(
          :lat => p[1]["latE6"] / 1e6,
          :lng => p[1]["lngE6"] / 1e6,
        ).first_or_create(
          :name    => p[1]["name"],
          :address => p[1]["address"],
        )
        logger.info 'portal: %s' % portal.inspect
        # player info
        player = result[2]["plext"]["markup"].find do |e|
          e[0] == "PLAYER"
        end
        # insert log
        captured_log = CapturedLog.where(
          :guid        => result[0],
        ).first_or_create(
          :portal      => portal,
          :captured_at => Time.at(result[1] / 1e3),
          :player      => player[1]["plain"],
          :team        => player[1]["team"],
        )
        logger.info 'captured log: %s' % captured_log.inspect
      end

      sleep 15.minutes
    end
  end
end
