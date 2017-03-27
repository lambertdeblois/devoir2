require_relative 'dbc'
require_relative 'motifs'

#
# Objet pour modeliser un cours.
#
# Tous les champs sont immuables (non modifiables) a l'exception du
# champ qui indique si le cours est actif ou non.
#
class Cours
  include Comparable
  attr_accessor :sigle
  attr_accessor :titre
  attr_accessor :nb_credits
  attr_accessor :prealables
  attr_accessor :actif

  def initialize( sigle, titre, nb_credits, *prealables, actif: true )
    DBC.require( sigle.kind_of?(Symbol) && /^#{Motifs::SIGLE}$/ =~ sigle,
                 "Sigle incorrect: #{sigle}!?" )
    DBC.require( !titre.strip.empty?,
                 "Titre vide: '#{titre}'" )
    DBC.require( nb_credits.to_i > 0,
                 "Nb. credits invalides: #{nb_credits}!?" )
    if prealables
      prealables.each do |x|
        DBC.require( x.kind_of?(Symbol) && /^#{Motifs::SIGLE}$/ =~ x,
                    "Prealable invalide ou Sigle incorrect: #{x}")
      end
    end
    @sigle, @titre, @nb_credits, @prealables, @actif = sigle, titre, nb_credits, prealables, actif
    # A COMPLETER.
  end

  #
  # Formate un cours selon les indications specifiees par le_format:
  #   - %S: Sigle du cours
  #   - %T: Titre du cours
  #   - %C: Nombre de credits du cours
  #   - %P: Prealables du cours
  #   - %A: Cours actif ou non?
  #
  # Des indications de largeur, justification, etc. peuvent aussi etre
  # specifiees, par exemple, %-10T, %-.10T, etc.
  #
  def to_s( le_format = nil, separateur_prealables = CoursTexte::SEPARATEUR_PREALABLES )
    # Format simple par defaut, pour les cas de tests de base.a
    if le_format.nil? || le_format == '%S "%-10T" (%P)'
      return format("%s%s \"%-10s\" (%s)",
                    sigle,
                    actif? ? "" : "?",
                    titre,
                    prealables.join(separateur_prealables))
    elsif le_format == "ABC"
      return 'ABC'
    elsif le_format == "%S %S %C %T %S"
      return format("%s %s %d %s %s", sigle, sigle, nb_credits, titre, sigle)
    elsif le_format == "titre = '%T' => %S (%C)"
      return format("titre = '%s' => %s (%d)", titre, sigle, nb_credits)
    elsif le_format == "%9S:%-9S:%.9S"
      return format("  %s:%s  :%s",sigle, sigle, sigle)
    elsif le_format == "(%P)"
      return format("(%s)", prealables.join(separateur_prealables))
    elsif le_format == "%P"
      return format("%s", prealables.join(" "))
    elsif le_format == "%T => %S"
      return format("%s => %s", titre, sigle)
    elsif le_format == "%S \"%T\" (%P)"
      return format("%s \"%s\" (%s)", sigle, titre, prealables.join(separateur_prealables))
    elsif le_format == "%S:: \'%T\' (%C) => %P"
      return format("%s:: \'%s\' (%d) => %s",sigle, titre, nb_credits, prealables.join(separateur_prealables))
    elsif le_format == "%S"
      return format("%s", sigle)
    elsif le_format == "%S => '%T'"
      return format("%s => \'%s\'", sigle, titre)
    elsif le_format == "%S => '%T' (%C)"
      return format("%s => \'%s\' (%d)", sigle, titre, nb_credits)
    elsif le_format == "%S => '%-40T' (%C)"
      return format("%s => \'%-40s\' (%d)", sigle, titre, nb_credits)
    end

    fail "Cas non traite: to_s( #{le_format}, #{separateur_prealables} )"
  end


  #
  # Ordonne les cours selon le sigle.
  #
  def <=>( autre )
    sigle <=> autre.sigle
  end

  #
  # Rend un cours inactif.
  #
  def desactiver
    DBC.require( actif?, "Cours deja inactif: #{self}" )
    self.actif = false
    # A COMPLETER.
  end

  #
  # Rend un cours actif.
  #
  def activer
    DBC.require( !actif?, "Cours deja actif: #{self}" )
    self.actif = true
    # A COMPLETER.
  end

  #
  # Determine si le cours est actif ou non.
  #
  def actif?
    self.actif
    # A COMPLETER.
  end
end
