require 'see_double'

describe SeeDouble do
  it 'return an array of path and its expects' do
    expect(GetDataFromSpec.resultat_trie 'expect'). to eq [["./rails_app/dummy/spec/show_spec.rb", "artwork"]]
  end
end
