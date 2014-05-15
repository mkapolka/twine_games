class Actor

window.actor_classes  = [
    class Lamp extends Actor
        name: 'The table lamp'
        act: (others) ->
            other = others.random()
            @name + " " + [
                'shines light on',
                'refuses to shine light on',
                'blinds'
            ].random() + " " + other.name

    class CryingWoman extends Actor
        name: 'a crying woman'
        human: true
        act: (others) ->
            other = others.random()
            @name + " " + [
                'cries',
                'stops crying',
                'wails'
            ].random()

    class Chair extends Actor
        name: "The leather chair"
        act: (others) ->
            if not @seated?
                other = others.random()
                @seated = other
                return "#{@name} " + [
                    'seats',
                    "won't seat"
                ].random() + " " + other.name
            else
                other = @seated
                @seated = nil
                return "#{@name} " + [
                    'ejects'
                ].random() + " #{other.name}"

    class RedWoman extends Actor
        name: "a woman in red"
        human: true
        act: (others) ->
            other = others.random()
            old_name = @name
            @name = "her"
            string = "#{old_name} looks so pretty that " + other.act([this])
            @name = old_name
            return string

    class Lawyer extends Actor
        name: "a lawyer"
        human: true
        act: (others) ->
            things = (x for x in others when not x.human)
            other = things.random()
            return "#{other.name} reminds #{@name} to study his case files"

    class Death extends Actor
        name: "death"
        act: (others) ->
            humans = (x for x in others when x.human)
            other = humans.random()
            if Math.random() < .2
                other.dead = true
                return "#{@name} comes for #{other.name}"
            else
                return "#{@name} cackles mercilessly"
]

window.spin_yarn = ->
    available_actors = (new x for x in window.actor_classes)
    actors = window.pick_actors(available_actors)    
    output = []
    console.log(actors)
    for i in [1..Math.random() * 3]
        actors = (a for a in actors when not a.dead)
        actor = actors.random()
        others = (a for a in actors when a != actor)
        output.push actor.act others
    string = ""
    for i in [0...output.length] by 2
        if output[i+1]?
            string = output[i] + [
                '.\n',
                ', and so ',
                ' therefore ',
                ' even though ',
                ' and then '
            ].random() + output[i+1]
        else
            string += output[i]
        
    return string
