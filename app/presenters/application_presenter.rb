class ApplicationPresenter < SimpleDelegator
  def initialize(model, view = nil)
    @view = view
    super(model)
  end

  def h
    @view
  end

  def self.to_proc
    method(:new).to_proc
  end
end
