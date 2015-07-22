class CloudFoundryEnvironment
  NoMongodbBoundError = Class.new(StandardError)

  def initialize(services = ENV.to_h.fetch("VCAP_SERVICES"))
    @services = JSON.parse(services)
  end

  def mongo_uri
    url = services['br_MongoDB'][0]['credentials']['MongoDB Server']['mongodb.server.endpoint'].split('http://')[-1]
    protocol = "mongodb://"
    protocol + url
  rescue KeyError
    raise NoMongodbBoundError
  end

  private

  attr_reader :services
end
