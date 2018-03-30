require 'see_double'
require 'active_support/core_ext/kernel/reporting'

describe SeeDouble do

  context 'with key word expect' do

    datas = [["./rails_app/dummy/spec/features/artworks/show_spec.rb", "artwork", "artwork", "artwork", "user", "user"], ["./rails_app/dummy/spec/home_spec.rb", "doudou", "doudou"]]

    it 'return an array of path and its expects' do
      expect(GetDataFromSpec.resultat_trie 'expect'). to eq datas
    end

    it 'return an array just with expects' do
      expect(CheckDuplication.trie_les_expects_et_les_noms_de_fichiers datas). to eq [["artwork", "artwork", "artwork", "user", "user"], ["doudou", "doudou"]]
    end

    it "should print the right informations on terminal" do
      method_output = CheckDuplication.recupere_data_from_spec('expect')
      expect do
        CheckDuplication.recupere_data_from_spec('expect')
      end.to output(method_output).to_stdout
    end
  end

  context 'with key word result' do

    datas = [["./rails_app/dummy/spec/admin_spec.rb", " \"L'origine du monde 1\"", " \"L'origine du monde 2\"", " \"L'origine du monde 3\""], ["./rails_app/dummy/spec/features/artworks/new_spec.rb", " artwork_path Artwork.last", " user.name"], ["./rails_app/dummy/spec/features/artworks/show_spec.rb", " artwork.name", " artwork.price", " artwork.owner", " 'Popi'", " '22'"], ["./rails_app/dummy/spec/features/users/show_spec.rb", " user.name", " user.first_name", " artwork.name", " artwork.price", " artwork.size"], ["./rails_app/dummy/spec/home_spec.rb", " artwork.name", " artwork.price"]]

    it 'return an array of path and its results' do
      expect(GetDataFromSpec.resultat_trie 'result'). to eq datas
    end

    it 'return an array just with results' do
      expect(CheckDuplication.trie_les_expects_et_les_noms_de_fichiers datas). to eq [[" \"L'origine du monde 1\"", " \"L'origine du monde 2\"", " \"L'origine du monde 3\""], [" artwork_path Artwork.last", " user.name"], [" artwork.name", " artwork.price", " artwork.owner", " 'Popi'", " '22'"], [" user.name", " user.first_name", " artwork.name", " artwork.price", " artwork.size"], [" artwork.name", " artwork.price"]]
    end

    it "should print the right informations on terminal" do
      method_output = CheckDuplication.recupere_data_from_spec('result')
      expect do
        CheckDuplication.recupere_data_from_spec('result')
      end.to output(method_output).to_stdout
    end

  end
end
