class ApplicationController < ActionController::API
  include ActionController::Cookies

  def hello_world
    session[:count] = (session[:count] || 0) + 1
    render json: { count: session[:count] }
  end

  def inspections

    url = 'https://api.safetyculture.io/audits/search?field=audit_id&field=modified_at'
    response = Faraday.get(url, nil, {'Authorization' => "Bearer #{ENV['IAUDITOR']}"})
    data = JSON.parse(response.body, symbolize_names: true)
    render json: {data: data, status: :ok}


  end
end
