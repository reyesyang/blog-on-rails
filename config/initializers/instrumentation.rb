JSON_LOGGER = ActiveSupport::Logger.new("log/#{Rails.env}.json.log")

def log_event?(event)
  case event.name
  when /active_record$/ then log_active_record_event?(event)
  else true
  end
end

def log_active_record_event?(event)
  !['SCHEMA', 'ActiveRecord::SchemaMigration Load'].include?(event.payload[:name])
end

def event_type(event)
  case event.name
  when /(action_controller)$/ then 'request'
  when /active_record$/ then 'database'
  when /action_view$/ then 'view'
  else 'unknown'
  end
end

[
  'process_action.action_controller',
  /^(render_template|render_partial)\.action_view$/,
  'sql.active_record'
].each do |event|
  ActiveSupport::Notifications.subscribe event do |*args|
    event = ActiveSupport::Notifications::Event.new *args

    if log_event?(event)
      JSON_LOGGER.info({
        project: 'ott-wildfire-cms',
        request_uuid: Thread.current['request_uuid'],
        type: event_type(event),
        begin_at: event.time,
        end_at: event.end,
        duration: event.duration.round(2),
        payload: event.payload
      }.to_json)
    end
  end
end
