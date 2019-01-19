require 'droplet_kit'

TOKEN = ENV['DO_ACCESS_TOKEN']
FLOATING_IP_ID = '138.68.38.119'
QUASARS_APP_GREEN_ID = 94899103
QUASARS_APP_BLUE_ID = 129410947


namespace :digital_ocean do
  desc "Change floating IP assignment"
  task :floating_ip, [:deploy] => :environment do |tasks, args|
    if args[:deploy] == 'green'
      deploy_target_id = QUASARS_APP_GREEN_ID
    else
      deploy_target_id = QUASARS_APP_BLUE_ID
    end

    client = DropletKit::Client.new(access_token: TOKEN)
    client.floating_ip_actions.assign(
      ip: FLOATING_IP_ID,
      droplet_id: deploy_target_id
    )
  end
end
