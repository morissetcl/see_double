require 'check_duplication'
require 'check_expect'

module SeeDouble
  def check_duplication_spec spec
    CheckDuplication.recupere_data_from_spec(spec)
  end
end
