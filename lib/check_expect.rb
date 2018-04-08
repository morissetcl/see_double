require 'rails'

class GetDataFromSpec
  class << self

    def resultat_trie mot_cle
      datas = recupere_data mot_cle
      contenu_trie = []
      itere_sur_chaque_ligne_des_expects(datas, contenu_trie, mot_cle)
      clean_result(contenu_trie)
    end

    private

    def recupere_data mot_cle
      specs_content = parcours_spec_et_recupere_content
      if mot_cle == 'result'
        expect = ['expect'].freeze #mot clé pour choper les expects
      else
        expect = [mot_cle].freeze
      end
      datas = []
      parcours_recupere_data(specs_content, expect, datas)
      datas
    end

    def parcours_spec_et_recupere_content
      specs_content = []
      Dir.glob(renvoie_le_bon_chemin) do |spec_path|
        spec_file_content = []
        ajoute_path_dans_array(spec_file_content, spec_path)
        File.foreach(spec_path) do |line|
          spec_file_content << line.strip
        end
        specs_content << spec_file_content
      end
      specs_content
    end

    def renvoie_le_bon_chemin
      Dir.exist?("./rails_app/dummy") ? "./rails_app/dummy/spec/**/*.rb" : "./spec/features/**/*.rb"
    end

    def parcours_recupere_data(specs_content, mot_cle, data_currated )
      specs_content.each do |lines|
        expect_pour_un_fichier = []
        lines.each do |line|
          ajoute_path_dans_array(expect_pour_un_fichier, lines.first)
          recupere_contenu_des_expects(line, expect_pour_un_fichier, mot_cle)
        end
        data_currated.push(expect_pour_un_fichier)
      end
    end

    def ajoute_path_dans_array(array, element)
      array << element unless array.include? element
    end

    def recupere_contenu_des_expects(line, array, mot_cle)
      line.split(/\W+/).each do |a|
        return unless mot_cle.include?(a)
        array.push(line)
      end
    end

    def itere_sur_chaque_ligne_des_expects(array_initial, array_resultat, mot_cle)
      array_initial.each do |line|
        contenu = []
        contenu << line.first
        if mot_cle == 'result'
          recupere_le_contenu_du_resultat_attendu(line, contenu)
        else
          recupere_contenu_entre_parenthese(line, contenu)
        end
        array_resultat << contenu
      end
    end

    def recupere_contenu_entre_parenthese(line, array_initial)
      line.each do |a|
        array_initial << a.scan(/\((.*)\)/)
        array_initial.delete_if { |s| s.empty? }
      end
    end

    def recupere_le_contenu_du_resultat_attendu(line, array_initial)
      line.each do |a|
        array_initial << a.scan(/^*have_content(.*)$/)
        array_initial << a.scan(/^*eq(.*)$/)
        array_initial.delete_if { |s| s.empty? }
      end
    end

    def clean_result(array)
      resultat_trie = array.map { |a| a.flatten }
      resultat_trie.each do |a|
        a.delete_if { |i| i == 'page'}
      end
      resultat_trie.delete_if { |a| a.length == 1 }
    end
  end
end
