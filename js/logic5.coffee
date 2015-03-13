# A: prémisse
# B : intermédiaire
# C : conclusion
  type = Math.floor(Math.random()*6)
  [a,b,c] = [0,0,0]
  ordre = [[0,1,1,2],[0,1,2,1],[0,1,1,2],[0,1,2,1],[1,0,2,1],[0,1,2,1]]
  qA = ["Tous les","Tous les","Quelques","Quelques","Aucun des","Quelques"]
  rB = ["sont des","sont des","sont des","sont des","ne sont des","ne sont pas des"]
  qB = ["tous les","aucun des","tous les","aucun des","tous les","tous les"]
  rC = ["sont des","ne sont des","sont","ne sont des","sont des","sont des"]
  A = ["suspect","policier","juge","avocat","chauffeur","majordome","détective","greffier"]
  B = ["noir","arabe","étranger","bavard","fumeur","muet","gangster","politicien"]
  C = ["gentil","coupable","malin","imbécile","innocent","méchant","escroc","prisonnier"]
  liste = [A,B,C]
  sol1 = ["Tous les","Aucun des","Quelques","Quelques","Aucun des","Quelques"]
  sol2 = ["sont des","ne sont des","sont des","ne sont pas des","ne sont des","ne sont pas des"]
  faireQCM = ->
    aleat = [Math.floor(Math.random()*8),Math.floor(Math.random()*8),Math.floor(Math.random()*8)]
    $("#probleme1").text "#{qA[type]} #{liste[ordre[type][0]][aleat[ordre[type][0]]]}s #{rB[type]} #{liste[ordre[type][1]][aleat[ordre[type][1]]]}s"
    $("#probleme2").text "#{qB[type]} #{liste[ordre[type][2]][aleat[ordre[type][2]]]}s #{rC[type]} #{liste[ordre[type][3]][aleat[ordre[type][3]]]}s"
    $("#sortie").text "#{sol1[type]} #{A[aleat[0]]}s #{sol2[type]} #{C[aleat[2]]}s"
    $(".sA").text " #{A[aleat[0]]}s "
    $(".sB").text " #{B[aleat[1]]}s "
    $(".sC").text " #{C[aleat[2]]}s"
    true
  $ ->
    faireQCM()
    $('.jeton').draggable()
      snap: false
    $('.cellule').droppable
      accept: ".jeton"
      tolerance: "intersect"
      drop: (event,ui) ->
        alert "dropped !!!"
        $('sortie').text $(this)
        true