require 'see_double'
require 'active_support/core_ext/kernel/reporting'

describe SeeDouble do

  context 'with key word expect' do

    datas =[["./rails_app/dummy/spec/features/share_page_spec.rb", "\"Script served by Clément Rollon\""], ["./rails_app/dummy/spec/features/user_login_and_logout_spec.rb", "current_path", "new_user_session_path"], ["./rails_app/dummy/spec/home_spec.rb", "doudou", "doudou"]]

    xit 'return an array of path and its expects' do
      expect(GetDataFromSpec.resultat_trie 'expect'). to eq datas
    end

    it 'return an array just with expects' do
      expect(CheckDuplication.trie_les_expects_et_les_noms_de_fichiers datas). to eq  [["\"Script served by Clément Rollon\""], ["current_path", "new_user_session_path"], ["doudou", "doudou"]]
    end

    it "should print the right informations on terminal" do
      method_output = CheckDuplication.recupere_data_from_spec('expect')
      expect do
        CheckDuplication.recupere_data_from_spec('expect')
      end.to output(method_output).to_stdout
    end
  end

  context 'with key word result' do

    datas = [["./rails_app/dummy/spec/features/share_page_spec.rb", "(\"Script served by Clément Rollon\")"], ["./rails_app/dummy/spec/features/user_login_and_logout_spec.rb", "(new_user_session_path)", " \"Signed in successfully\"", " \"You have to confirm your email address before continuing\"", " \"Invalid email or password\"", " \"You have one more attempt before your account is locked\"", " \"Signed in successfully\"", " \"You have to confirm your email address before continuing\""], ["./rails_app/dummy/spec/home_spec.rb", " artwork.name", " artwork.price"], ["./rails_app/dummy/spec/admin_spec.rb", " \"L'origine du monde 1\"", " \"L'origine du monde 2\"", " \"L'origine du monde 3\""]]

    xit 'return an array of path and its results' do
      expect(GetDataFromSpec.resultat_trie 'result'). to eq datas
    end

    it "should print the right informations on terminal" do
      method_output = CheckDuplication.recupere_data_from_spec('result')
      expect do
        CheckDuplication.recupere_data_from_spec('result')
      end.to output(method_output).to_stdout
    end

  end
end
