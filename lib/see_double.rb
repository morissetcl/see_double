require_relative 'check_duplication'
require_relative 'check_expect'

module SeeDouble
  def check_duplication_spec spec
    CheckDuplication.recupere_data_from_spec(spec)
  end
end
