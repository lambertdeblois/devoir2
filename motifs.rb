#
# Module qui regroupe des constantes definissant les divers motifs
# pour identifier les champs d'un cours.
#
module Motifs
  # Motifs mots representant sigle, titre, nommbre (de credits) et prealables.
  #
  # Rappel: les deux facons suivantes permettent de definir un objet Rexexp.
  #   %r{...}
  #   /.../

  SIGLE =  %r{\b[A-Z]{3}[0-9]{3}[A-Z0-9]\b}
  TITRE = %r{\w+}
  NOMBRE = %r{\d}
  PREALABLES = %r{([A-Z]{3}[0-9]{3}[A-Z0-9] *)+}
  DEPOT = %r{--depot\s*=.+}
  DETRUIRE = %r{\s*--detruire}

  # Motif pour un cours complet
  COURS = %r{\A(#{SIGLE}) *(#{TITRE}) *(#{NOMBRE}) *(#{PREALABLES})?\z}
  # \A(\b[A-Z]{3}[0-9]{3}[A-Z0-9]\b) *(\w+) *(\d) *((\b[A-Z]{3}[0-9]{3}[A-Z0-9]\b *)+)?\z
end
