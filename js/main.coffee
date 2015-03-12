# A: prémisse
# B : intermédiaire
# C : conclusion
  type = 0
  [a,b,c] = [0,0,0]
  ordre = [[a,b,b,c],[a,b,c,b],[a,b,b,c],[a,b,c,b],[b,a,c,b],[a,b,c,b]]
  qA = ["Tous les","Tous les","Quelques","Quelques","Aucun des","Quelques"]
  rB = ["sont des","sont des","sont des","sont des","ne sont des","ne sont pas des"]
  qB = ["tous les","aucun des","tous les","aucun des","tous les","tous les"]
  rC = ["sont des","ne sont des","ne sont pas des","ne sont des","sont des","tous les"]
  A = ["suspect","policier","juge","avocat","chauffeur","majordome"]
  B = ["noir","arabe","étranger","bavard","fumeur","muet"]
  C = ["gentil","coupable","malin","imbécile","innocent","méchant"]
  liste = [A,B,C]
  soln = [[a,c],[a,c],[a,c],[a,c],[a,c],[a,c]]
  sol1 = ["Tous les","Aucun des","Quelques","Quelques","Aucun des","Quelques"]
  sol2 = ["sont des","ne sont des","sont des","ne sont pas des","ne sont des","ne sont pas des"]
  faireQCM = ->
    aleat = [Math.floor(Math.random()*6),Math.floor(Math.random()*6),Math.floor(Math.random()*6)]
    $("#probleme1").text "#{qA[type]} #{liste[ordre[type][0]][aleat[ordre[type][0]]]}s #{rB[type]} #{liste[ordre[type][1]][aleat[ordre[type][1]]]}s"
    $("#probleme2").text "#{qB[type]} #{liste[ordre[type][2]][aleat[ordre[type][2]]]}s #{rC[type]} #{liste[ordre[type][3]][aleat[ordre[type][3]]]}s"
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