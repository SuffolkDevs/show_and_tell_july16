class Promotion

  attr_reader :id, :type, :params

  def initialize(id:, type:, params:)
    raise "error: entry not correct" if id.nil? || type.nil? || params.nil?
    @id = id
    @type = type
    @params = params
  end
end