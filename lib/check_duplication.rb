require 'rails'
require_relative 'check_expect'
require 'colorize'

class CheckDuplication
  class << self
    def recupere_data_from_spec(arg)
      check_si_arg_est_valide(arg)
      return unless mot_cles_gere_par_la_gem?(arg)
      datas = GetDataFromSpec.resultat_trie(arg)
      trie_les_expects_et_les_noms_de_fichiers(datas)
      identifie_duplication_au_sein_d_un_mm_file(datas, arg)
    end

    def check_si_arg_est_valide(arg)
      print message_erreur(arg) unless mot_cles_gere_par_la_gem?(arg)
    end

    def message_erreur(arg)
      "Sorry we does not handle '#{arg}', feel free to make a PR about ! ;)"
    end

    def mot_cles_gere_par_la_gem?(mot_cle)
      array = ['expect', 'result']
      array.include?(mot_cle)
    end

    def trie_les_expects_et_les_noms_de_fichiers(datas)
      @array_filename = []
      datas.each do |a|
        @array_filename << a.first
        a.shift
      end
    end

    def identifie_duplication_au_sein_d_un_mm_file(datas, arg)
      duplication_final = []
      datas.each do |data|
        duplication = []
        data.each{ |expect| duplication << expect }
        duplication_final << duplication.flatten
      end
      formate_les_resultats_par_fichier(duplication_final, arg)
    end

    def formate_les_resultats_par_fichier(duplication_final, arg)
      array_reconstitue = @array_filename.zip(duplication_final)
      return if arg.nil?
      affiche_les_resultats_par_fichier(array_reconstitue, arg)
      affiche_les_resultats_pour_ensemble_des_specs(array_reconstitue, arg)
    end

    private

    def affiche_les_resultats_par_fichier(arr_trie, arg)
      display_result = []
      formate_le_nbre_d_occurence(display_result,arr_trie)
      affiche_les_resultats_dans_le_teminal(display_result, arg)
    end

    def formate_le_nbre_d_occurence(display_result,arr_trie)
      arr_trie.each do |a|
        hash_count = a.last.inject(Hash.new(0)) {|h,i| h[i] += 1; h }
        hash_count.to_a.map { |expect_name,count| display_result <<  [a.first, expect_name.delete('()'), count] }
        print ".".colorize(color: COLORS.sample)
        sleep(0.2)
      end
      puts "\n\n"
    end

    def affiche_les_resultats_dans_le_teminal(display_result, arg)
      result_triee_par_file = display_result.sort_by(&:last).reverse
      path = []
      puts "----- Analyze of your #{arg} from each features specs -----"
      result_triee_par_file.each do |a|
        if !path.include?(a.first)
          path.push(a.first)
          puts "\n"
          puts "#{a.first.green}:"
        end
        output = "you use #{a[2].to_s.light_red} times #{a[1].light_red} as #{arg}"
        puts output unless a[1].blank?
      end
    end

    def trie_les_resultats_pour_ensemble_des_specs(arr_trie)
      global_array = arr_trie.flatten.flatten
      global_hash =  global_array.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
      global_hash.delete_if { |k, v| v <= 1 }
      @global_array_trie = global_hash.sort_by(&:last).reverse
    end

    def affiche_les_resultats_pour_ensemble_des_specs(arr_trie, arg)
      puts "\n\n"
      puts "----- Analyze of your #{arg} from all yours specs -----"
      puts "\n"
      trie_les_resultats_pour_ensemble_des_specs(arr_trie)
      @global_array_trie.map do |expect_name,count|
        puts "You use #{count.to_s.light_red} times the #{expect_name.light_red} as #{arg}"
      end
      puts "\n"
    end
  end
end

COLORS = [:light_black, :red, :light_red, :green, :light_green, :yellow, :light_yellow, :blue, :light_blue, :magenta, :light_magenta, :cyan, :light_cyan]
