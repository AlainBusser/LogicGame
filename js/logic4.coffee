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
  B = ["noir","blanc","ripou","bavard","fumeur","muet","gangster","politicien"]
  C = ["gentil","coupable","malin","imbécile","innocent","méchant","escroc","prisonnier"]
  liste = [A,B,C]
  sol1 = ["Il n'y a pas de","Il n'y a que des"]
  trad = ["non-",""]
  
  ############################## fabrication des syllogismes et de leurs solutions dans le QCM ##########
  
  faireQCM = ->
    aleat = [Math.floor(Math.random()*8),Math.floor(Math.random()*8),Math.floor(Math.random()*8)]
#    $("#probleme1").text "#{qA[type]} #{liste[ordre[type][0]][aleat[ordre[type][0]]]}s #{rB[type]} #{liste[ordre[type][1]][aleat[ordre[type][1]]]}s"
#    $("#probleme2").text "#{qB[type]} #{liste[ordre[type][2]][aleat[ordre[type][2]]]}s #{rC[type]} #{liste[ordre[type][3]][aleat[ordre[type][3]]]}s"
#    $(".sA").text " #{A[aleat[0]]}s "
    $(".sB").text " #{B[aleat[1]]}s "
    $(".sC").text " #{C[aleat[2]]}s "
    exercice = "#{sol1[Math.floor(Math.random()*2)]} "
    if Math.random()>0.5
      exercice += "#{C[aleat[2]]}s"
    else
      exercice += "#{B[aleat[1]]}s"
    $("#question").text exercice
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
            if milieu is 1
              textsortie = "Le dernier jeton code le fait qu'aucun #{trad[fin]}#{C[aleat[2]]} n'est #{B[aleat[1]]}"
            else
              textsortie = "Le dernier jeton code le fait que tout #{trad[fin]}#{C[aleat[2]]} est #{B[aleat[1]]}"
        else # si le jeton n'est pas gris c'est qu'il est rouge
          if debut is 1
            textsortie = "Le dernier jeton code le fait qu'il existe quelqu'un qui n'est pas #{B[aleat[1]]}"
          else
            textsortie = "Le dernier jeton code le fait qu'il existe un #{trad[fin]}#{C[aleat[2]]}  #{trad[milieu]}#{B[aleat[1]]}"
        $('#sortie').text textsortie
        true