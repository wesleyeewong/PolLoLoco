module RequestHelper
  %i[get post patch put delete].each do |verb|
    define_method(:"authorized_#{verb}") do |user, endpoint, **options|
      options.symbolize_keys!
      headers = options[:headeres] || {}
      params = options[:params] || {}
      headers.merge!(authorization_header(user))
      send(verb, endpoint, headers:, params:)
    end
  end

  def authorization_header(user)
    {Authorization: "Bearer #{Jwt::Encoder.call(user.id)}"}
  end
end
