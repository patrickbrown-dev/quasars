require 'droplet_kit'

TOKEN = ENV['DO_ACCESS_TOKEN']
FLOATING_IP_ID = '138.68.38.119'.freeze
QUASARS_APP_GREEN_ID = 94_899_103
QUASARS_APP_BLUE_ID = 129_410_947

namespace :digital_ocean do
  desc 'Change floating IP assignment'
  task :floating_ip, [:deploy] => :environment do |_tasks, args|
    deploy_target_id = if args[:deploy] == 'green'
                         QUASARS_APP_GREEN_ID
                       else
                         QUASARS_APP_BLUE_ID
                       end

    client = DropletKit::Client.new(access_token: TOKEN)
    client.floating_ip_actions.assign(
      ip: FLOATING_IP_ID,
      droplet_id: deploy_target_id
    )
  end
end
