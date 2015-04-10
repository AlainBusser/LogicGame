# A: prémisse
# B : intermédiaire
# C : conclusion
#  type = Math.floor(Math.random()*6)  # type de syllogisme
  aleat = [0,0,0]  # les catégories socioprofessionnelles
  ordre = [[0,1,1,2],[0,1,2,1],[0,1,1,2],[0,1,2,1],[1,0,2,1],[0,1,2,1]] # ordre dans lequel écrire les catégories dans l'énoncé
  # 6 catégories de syllogismes
  qA = ["Tout","Tout","Quelque","Quelque","Aucun","Quelque"]
  rB = ["est","est","est","est","n'est","n'est pas"]
  qB = ["tout","aucun","tout","aucun","tout","tout"]
  rC = ["est","n'est","est","n'est","est","est"]
  # 8 catégories socioprofessionnelles, on peut augmenter
  A = ["suspect","policier","juge","avocat","chauffeur","majordome","détective","greffier"]
  B = ["noir","arabe","étranger","bavard","fumeur","muet","gangster","politicien"]
  C = ["gentil","coupable","malin","imbécile","innocent","méchant","escroc","prisonnier"]
  liste = [A,B,C]
  sol1 = ["Il n'y a pas de","Il n'y a que des"]
  trad = ["non-",""]
  
  ############################## fabrication des syllogismes et de leurs solutions dans le QCM ##########
  
  faireQCM = ->
    aleat = [Math.floor(Math.random()*8),Math.floor(Math.random()*8),Math.floor(Math.random()*8)]
#    $("#probleme1").text "#{qA[type]} #{liste[ordre[type][0]][aleat[ordre[type][0]]]}s #{rB[type]} #{liste[ordre[type][1]][aleat[ordre[type][1]]]}s"
#    $("#probleme2").text "#{qB[type]} #{liste[ordre[type][2]][aleat[ordre[type][2]]]}s #{rC[type]} #{liste[ordre[type][3]][aleat[ordre[type][3]]]}s"
    $(".sA").text " #{A[aleat[0]]}s "
#    $(".sB").text " #{A[aleat[0]]}s "
    $(".sC").text " #{B[aleat[1]]}s "
    true
    
    #########################  maintenant qu'on a un DOM on peut y aller #######################
    
  $ ->
    faireQCM()
    
    # pour qu'on puisse bouger les jetons
    $('.jeton').draggable
      snap: false
    
          
    # gestion des jetons: Des cas ambigüs subsistent, pas grave
    $('.cellule').droppable
      accept: ".jeton"
      tolerance: "intersect"
      drop: (event,ui) ->
        diagnostic = $(this).attr("id").split("prem")[1]
        diagnostic = diagnostic.split("conc")
        debut = parseInt diagnostic[0]
        diagnostic = diagnostic[1].split("mid")
        milieu = parseInt diagnostic[1]
        fin = parseInt diagnostic[0]
        if ui.draggable.hasClass 'gris'
          if debut is 1 # on est à gauche
              textsortie = "Le dernier jeton code le fait qu'il n'y a pas de #{A[aleat[0]]}"
            else
              textsortie = "Le dernier jeton code le fait qu'il n'y a que des #{A[aleat[0]]}s"
        else # si le jeton n'est pas gris c'est qu'il est rouge
              if debut is 1 # on est à gauche
                textsortie = "Le dernier jeton code le fait qu'il existe un #{A[aleat[0]]}"
              else
                textsortie = "Le dernier jeton code le fait qu'il existe quelqu'un qui n'est pas #{A[aleat[0]]}"
              
        $('#sortie').text textsortie
        true