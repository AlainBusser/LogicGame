# A: prémisse
# B : intermédiaire
# C : conclusion
  type = Math.floor(Math.random()*6)  # type de syllogisme
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
  sol1 = ["Tout","Aucun","Quelque","Quelque","aucun","Quelque"]
  sol2 = ["est","n'est","est","n'est pas","n'est","n'est pas"]
  trad = ["non-",""]
  
  ############################## fabrication des syllogismes et de leurs solutions dans le QCM ##########
  
  faireQCM = ->
    aleat = [Math.floor(Math.random()*8),Math.floor(Math.random()*8),Math.floor(Math.random()*8)]
    $("#probleme1").text "#{qA[type]} #{liste[ordre[type][0]][aleat[ordre[type][0]]]} #{rB[type]} #{liste[ordre[type][1]][aleat[ordre[type][1]]]}"
    $("#probleme2").text "#{qB[type]} #{liste[ordre[type][2]][aleat[ordre[type][2]]]} #{rC[type]} #{liste[ordre[type][3]][aleat[ordre[type][3]]]}"
#    $("#sortie").text "#{sol1[type]} #{A[aleat[0]]} #{sol2[type]} #{C[aleat[2]]}"
    $(".sA").text " #{A[aleat[0]]}"
    $(".sB").text " #{B[aleat[1]]}"
    $(".sC").text " #{C[aleat[2]]}"
    for option in [0..3]
      $("#o#{option}").text "#{sol1[option]} #{A[aleat[0]]} #{sol2[option]} #{C[aleat[2]]}"
    true
    
    #########################  maintenant qu'on a un DOM on peut y aller #######################
    
  $ ->
    faireQCM()
    
    # pour qu'on puisse bouger les jetons
    $('.jeton').draggable
      snap: false
    
    # fabrication du QCM, avec menu déroulant, et gestion    
    $('#proposition').selectmenu
      change: (event,data)->
        choix = parseInt data.item.value.split('solution')[1]
#        $("#sortie").text $("#o#{choix}").text()
        if choix is 4
          alert "Si, si, ce syllogisme a une solution !"
        else
          if type is choix or (type is 4 and choix is 1) or (type is 5 and choix is 3)
            alert "Bravo, la conclusion est effectivement que : \n #{sol1[choix]} #{A[aleat[0]]} #{sol2[choix]} #{C[aleat[2]]}"
          else
            alert "Non, la conclusion du syllogisme n'est pas que :\n #{sol1[choix]} #{A[aleat[0]]} #{sol2[choix]} #{C[aleat[2]]}"
          
          
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
          if debut>1 or fin>1
            textsortie = "N'auriez-vous pas plutôt dû utiliser un jeton rouge ?"
          else
            if milieu is 1
              textsortie = "Vous venez de coder le fait qu'aucun #{trad[debut]}#{A[aleat[0]]} #{trad[fin]}#{C[aleat[2]]} n'est #{B[aleat[1]]}"
            else
              textsortie = "Vous venez de coder le fait que tout #{trad[debut]}#{A[aleat[0]]} #{trad[fin]}#{C[aleat[2]]}s est #{B[aleat[1]]}"
        else
          if debut<=1 and fin<=1
            textsortie = "N'auriez-vous pas plutôt dû utiliser un jeton gris ?"
          else
            if debut>1
              textsortie = "Vous venez de coder le fait que quelque #{trad[fin]}#{C[aleat[2]]} n'est pas #{B[aleat[1]]}"
            else
              textsortie = "Vous venez de coder le fait que quelque #{trad[debut]}#{A[aleat[0]]} n'est pas #{B[aleat[1]]}"
        $('#sortie').text textsortie
        true