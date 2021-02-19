CandidateDetails = Struct.new(:timestamp, :first_name, :last_name, :email, :phone_number) do
  def initialize(timestamp, *columns)
    super(DateTime.strptime(timestamp, "%m/%d/%Y %H:%M:%S"), *columns)
  rescue
    super
  end

  def self.to_proc
    -> row { new *row }
  end
end
