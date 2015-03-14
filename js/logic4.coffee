# A: prémisse
# B : intermédiaire
# C : conclusion
  type = Math.floor(Math.random()*6)  # type de syllogisme
  aleat = [0,0,0]  # les catégories socioprofessionnelles
  ordre = [[0,1,1,2],[0,1,2,1],[0,1,1,2],[0,1,2,1],[1,0,2,1],[0,1,2,1]] # ordre dans lequel écrire les catégories dans l'énoncé
  # 6 catégories de syllogismes
  qA = ["Tous les","Tous les","Quelques","Quelques","Aucun des","Quelques"]
  rB = ["sont des","sont des","sont des","sont des","ne sont des","ne sont pas des"]
  qB = ["tous les","aucun des","tous les","aucun des","tous les","tous les"]
  rC = ["sont des","ne sont des","sont","ne sont des","sont des","sont des"]
  # 8 catégories socioprofessionnelles, on peut augmenter
  A = ["suspect","policier","juge","avocat","chauffeur","majordome","détective","greffier"]
  B = ["noir","arabe","étranger","bavard","fumeur","muet","gangster","politicien"]
  C = ["gentil","coupable","malin","imbécile","innocent","méchant","escroc","prisonnier"]
  liste = [A,B,C]
  sol1 = ["Tous les","Aucun des","Quelques","Quelques","Aucun des","Quelques"]
  sol2 = ["sont des","ne sont des","sont des","ne sont pas des","ne sont des","ne sont pas des"]
  trad = ["non-",""]
  
  ############################## fabrication des syllogismes et de leurs solutions dans le QCM ##########
  
  faireQCM = ->
    aleat = [Math.floor(Math.random()*8),Math.floor(Math.random()*8),Math.floor(Math.random()*8)]
    $("#probleme1").text "#{qA[type]} #{liste[ordre[type][0]][aleat[ordre[type][0]]]}s #{rB[type]} #{liste[ordre[type][1]][aleat[ordre[type][1]]]}s"
    $("#probleme2").text "#{qB[type]} #{liste[ordre[type][2]][aleat[ordre[type][2]]]}s #{rC[type]} #{liste[ordre[type][3]][aleat[ordre[type][3]]]}s"
#    $("#sortie").text "#{sol1[type]} #{A[aleat[0]]}s #{sol2[type]} #{C[aleat[2]]}s"
#    $(".sA").text " #{A[aleat[0]]}s "
    $(".sB").text " #{B[aleat[1]]}s "
    $(".sC").text " #{C[aleat[2]]}s "
    for option in [0..3]
      $("#o#{option}").text "#{sol1[option]} #{A[aleat[0]]}s #{sol2[option]} #{C[aleat[2]]}s"
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
          if debut>2 or fin>1
            textsortie = "Ne fallait-il pas plutôt utiliser un jeton rouge ?"
          else
            if milieu is 1
              textsortie = "Le dernier jeton code le fait qu'aucun #{trad[fin]}#{C[aleat[2]]} n'est #{B[aleat[1]]}"
            else
              textsortie = "Le dernier jeton code le fait que tous les #{trad[fin]}#{C[aleat[2]]}s sont #{B[aleat[1]]}s"
        else # si le jeton n'est pas gris c'est qu'il est rouge
          if debut<=2 and fin<=1
            textsortie = "Ne fallait-il pas plutôt utiliser un jeton gris ?"
          else
            if debut>1
              textsortie = "Le dernier jeton code le fait que quelques #{trad[fin]}#{C[aleat[2]]}s ne sont pas des #{B[aleat[1]]}s"
            else
              textsortie = "Le dernier jeton code le fait que quelques #{trad[debut]}#{A[aleat[0]]}s ne sont pas des #{B[aleat[1]]}s"
        $('#sortie').text textsortie
        true