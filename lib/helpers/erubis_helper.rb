module ErubisHelper
  def self.tabs(amount = 1)
    (0..amount).map { "\t" }.join
  end

  def self.spaces(amount = 1)
    (0..amount).map { "\s" }.join
  end
end
