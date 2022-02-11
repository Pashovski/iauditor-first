class ApplicationController < ActionController::API
  include ActionController::Cookies

  def hello_world
    session[:count] = (session[:count] || 0) + 1
    render json: { count: session[:count] }
  end

  def inspections

    url = 'https://api.safetyculture.io/audits/search?field=audit_id&template=template_da7367e3e98b4387a69eef6288c71b9e&modified_after=2022-02-10T00:00:00.000Z'
    response = Faraday.get(url, nil, {'Authorization' => "Bearer #{ENV['IAUDITOR']}"})
    data = JSON.parse(response.body, symbolize_names: true)
    audits = []
    data[:audits].each do |a|
      response = Faraday.get("https://api.safetyculture.io/audits/#{a[:audit_id]}", nil, {'Authorization' => "Bearer #{ENV['IAUDITOR']}"})
      data2 = JSON.parse(response.body, symbolize_names: true) 
      audits.push data2
    end
    render json: {audits: audits, status: :ok}
  end
end
