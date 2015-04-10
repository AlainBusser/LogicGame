# A: prémisse
# B : intermédiaire
# C : conclusion
  type = Math.floor(Math.random()*6)  # type de syllogisme
  [A,B,C] = ["machin","truc","chose"]  # les catégories socioprofessionnelles
  trad = ["non-",""]
  [s1,s2,s3,s4] = ["Tout","est","Tout","est"]
  
  ############################## fabrication des syllogismes et de leurs solutions ##########
  
  faireQCM = ->
    $(".sA").text " #{A} "
    $(".sB").text " #{B} "
    $(".sC").text " #{C} "
    $(".sxB").text " #{B} "
    $(".sxC").text " #{C} "
    resoudreSyll()
    
  resoudreSyll = ->
    solution = "On ne peut pas conclure"
    if s1 is "Tout"
      if s2 is "est"
        if s3 is "Tout"
          if s4 is "est"
            $(".sxB").text " #{B} "
            $(".sxC").text " #{C} "
            solution = "Tout #{A} est #{C}"
          else
            solution = "Le deuxième verbe n'est pas bon"
        else
          if s3 is "Aucun" and s4 is "n'est"
            $(".sxB").text " #{C} "
            $(".sxC").text " #{B} "
            solution = "Aucun #{A}s n'est #{C}"
      else
        solution = "Le premier verbe n'est pas bon"
    if s1 is "Quelque"
      if s2 is "est"
        if s3 is "Tout"
          if s4 is "est"
            $(".sxB").text " #{B} "
            $(".sxC").text " #{C} "
            solution = "Quelque #{A} est #{C}"
          else
            solution = "Le deuxième verbe n'est pas bon"
        else
          if s3 is "Aucun" and s4 is "n'est"
            $(".sxB").text " #{C} "
            $(".sxC").text " #{B} "
            solution = "Quelque #{C} n'est pas #{A}"
      else
        solution = "Le premier verbe n'est pas bon"
    if s3 is "Tout"
      if s4 is "est"
        if s1 is "Aucun"
          if s2 is "n'est"
            $(".sxB").text " #{C} "
            $(".sxC").text " #{B} "
            solution = "Aucun #{A} n'est #{C}"
          else
            solution = "Le premier verbe n'est pas bon"
        else
          if s1 is "Quelque" and s2 is "n'est pas"
            $(".sxB").text " #{C} "
            $(".sxC").text " #{B} "
            solution = "Quelque #{A} n'est pas #{C}"
      else
        solution = "Le deuxième verbe n'est pas bon"
    solution += "."
    $("#sorsyl").text solution
    
    #########################  maintenant qu'on a un DOM on peut y aller #######################
    
  $ ->
    faireQCM()
    
    # pour qu'on puisse bouger les jetons
    $('.jeton').draggable
      snap: false
    
    # entrée d'un texte (catégorie)    
    $("#eA").on "change", ->
      A = $("#eA").val()
      faireQCM()
    $("#eB").on "change", ->
      B = $("#eB").val()
      faireQCM()
    $("#eC").on "change", ->
      C = $("#eC").val()
      faireQCM()
          
          
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
              textsortie = "Vous venez de coder le fait qu'aucun #{trad[debut]}#{A} #{trad[fin]}#{C} n'est #{B}"
            else
              textsortie = "Vous venez de coder le fait que tous les #{trad[debut]}#{A}s #{trad[fin]}#{C}s sont #{B}s"
        else
          if debut<=1 and fin<=1
            textsortie = "N'auriez-vous pas plutôt dû utiliser un jeton gris ?"
          else
            if debut>1
              textsortie = "Vous venez de coder le fait que quelques #{trad[fin]}#{C}s ne sont pas des #{B}s"
            else
              textsortie = "Vous venez de coder le fait que quelques #{trad[debut]}#{A}s ne sont pas des #{B}s"
        $('#sortie').text textsortie
        true
        
    # calculateur de syllogismes par disjonction des cas
    $('#choixA').selectmenu
      change: (event,data)->
        s1 = data.item.value
        resoudreSyll()
    $('#verbe1').selectmenu
      change: (event,data)->
        s2 = data.item.value
        resoudreSyll()
    $('#choixB').selectmenu
      change: (event,data)->
        s3 = data.item.value
        resoudreSyll()
    $('#verbe2').selectmenu
      change: (event,data)->
        s4 = data.item.value
        resoudreSyll()

