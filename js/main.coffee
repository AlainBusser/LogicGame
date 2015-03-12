  n = 0
  A = ["suspect","policier","juge","avocat","chauffeur","majordome"]
  B = ["noir","arabe","étranger","bavard","fumeur","muet"]
  C = ["gentil","coupable","malin","imbécile","innocent","méchant"]
  faireQCM = ->
    a = Math.floor(Math.random()*6)
    $(".premisseA").text A[a]
    b = Math.floor(Math.random()*6)
    $(".premisseB").text B[b]
    c = Math.floor(Math.random()*6)
    $(".premisseC").text C[c]
    true
  $ ->
    faireQCM()
    $('.jeton').draggable()
      snap: false
    $('.cellule').droppable
      accept: ".jeton"
      tolerance: "intersect"
      drop: (event,ui) ->
        $('sortie').text $(this)
        true