module RequestHelper
  def response_json
    JSON.parse(response.body).tap do |response_json|
      if response_json.is_a? Array # rubocop:disable Style/CaseLikeIf
        response_json.map!(&:symbolize_keys)
      elsif response_json.is_a? Hash
        response_json.symbolize_keys!
      end
    end
  end
end

RSpec.configure do |config|
  config.include RequestHelper, type: :request
end
