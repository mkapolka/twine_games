window.human_body_parts = [
    'nose', 'eyes', 'forehead', 'scalp', 'left ear', 'right ear', 'cheek',
    'lips', 'tongue', 'chin', 'neck', "adam's apple", 'throat', 'shoulder blade',
    'shoulder', 'funny bone', 'forearm', 'elbow', 'wrist', 'left hand', 'right hand',
    'index finger', 'thumb', 'middle finger', 'ring finger', 'pinky', 'fingernail',
    'palm', 'heart', 'chest', 'ribs', 'stomach', 'kidney', 'lungs', 'belly button', 'hips',
    'genitals', 'taint', 'butt', 'thigh', 'knee', 'ankle', 'shin', 'heel', 'foot', 'big toe',
    'pinky toe'
]

class Actor
    genitive: () ->
        return @name + "'s"

class Human extends Actor
    human: true

class Thing extends Actor
    human: false

actor_classes = {}
window.actor_classes = actor_classes

class actor_classes.Lamp extends Thing
    off: false,
    burnt_out: false
    name: 'the table lamp'
    can_act: ->
        not @off and not @burnt_out
    healthy_act: (others) ->
        if not knows_thing('toilet') and Math.random() < .3
            return "#{@name} shines light on a pamphlet for [[toilets|MeetToilet]]"
        else
            other = others.random()
            return @name + " " + [
                "shines light on #{other.name}",
                "refuses to shine light on #{other.name}",
                "blinds #{other.name}",
                "bathes #{other.name} in bright light",
            ].random()

    act: (others) ->
        other = others.random()
        if not @off and not @burnt_out
            if Math.random() < .8
                return this.healthy_act(others)
            else
                if Math.random() < .5
                    @burnt_out = true
                    return "#{@name}'s bulb burns out. Darkness fills the room"
                else
                    @off = true
                    return "#{@name} becomes unplugged. Darkness fills the room"
        else if @off
            humans = (o for o in others when o.human)
            if humans.length > 0
                human = humans.random()
                @off = false
                return "#{human.name} turns #{@name} back on"
        else if @burnt_out
            humans = (o for o in others when o.human)
            if humans.length > 0
                human = humans.random()
                @burnt_out = false
                return "#{human.name} replaces the bulb of #{@name}"

class actor_classes.Chair extends Thing
    name: "the leather chair"
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
            @seated = null
            return "#{@name} " + [
                'ejects'
            ].random() + " #{other.name} onto the floor"

class actor_classes.Death extends Thing
    name: "death"
    gender: 'he'
    act: (others) ->
        humans = (x for x in others when x.human)
        if humans.length > 0
            other = humans.random()
            if Math.random() < .2
                other.dead = true
                return "#{@name} comes for #{other.name}"
            else
                return "#{@name} strikes fear into the heart of #{other.name}"
        else
            return "#{@name} cackles mercilessly"

class actor_classes.Stripper extends Human
    name: "the stripper"
    act: (others) ->
        humans = (x for x in others when x.human)
        if humans.length > 0
            other = humans.random()
            extra_actions = [
                "turns #{other.name} on",
                "gives #{other.name} a lap dance",
                "fucks #{other.name}"
            ]
        else
            extra_actions = []
        return "#{@name} " + [
            'looks sexy',
            'struts his stuff',
        ].concat(extra_actions).random()

class actor_classes.Blender extends Thing
    name: "the blender"
    act: (others) ->
        human = (x for x in others when x.human).random()
        other = others.random()
        return [
            "#{@name} purrs",
            "#{@name} blends the hand of #{human.name}",
            "#{@name} purrs",
            "#{@name} blends up some veggies for #{other.name}",
            "#{@name} vibrates in circles",
            "#{@name} whirs at #{other.name}",
            "#{@name} spins for #{other.name}",
            "#{@name} pours blended fruit juice onto #{other.name}"
            "a blade breaks off of #{@name} and lodges itself inside of #{human.genitive} #{window.human_body_parts.random()}"
        ].random()

class actor_classes.Toilet extends Thing
    name: "the toilet"
    act: (others) ->
        human = (x for x in others when x.human).random()
        other = others.random()
        return [
            "#{@name} slurps up #{human.genitive} shit",
            "#{@name} flushes",
            "#{@name} clogs up",
            "#{@name} makes a gurgling sound",
            "#{@name} splashes water on #{other.name}"
            "#{@name} refuses to flush"
            "#{@name} emits a disgusting smell"
            "#{@name} releases a noxious gas"
        ].random()

class actor_classes.Car extends Thing
    name: "your car"
    act: (others) ->
        human = (x for x in others when x.human).random()
        other = others.random()
        place = [
            "the mall", "the supermarket", "your work", "the hospital",
            "the school", "the cafe", "the gym", "the park", "the zoo"
        ].random()
        return [
            "#{@name} honks its horn at #{other.name}"
            "#{@name} runs over #{other.name}"
            "#{@name} breaks down",
            "#{@name} shines its high beams at #{other.name}",
            "#{@name} drives you to #{place}"
        ].random()

class actor_classes.Wallpaper extends Thing
    name: "the wallpaper"
    act: (others) ->
        human = (x for x in others when x.human).random()
        other = others.random()
        return [
            "#{@name} looks like vomiting cats"
            "#{@name} peels off in flakes and lands on #{other.name}"
            "#{@name} looks like #{other.genitive} name written over and over"
            "#{@name} undulates"
            "#{@name} looks like wiry men staring at #{human.name}"
            "#{@name} surrounds #{other.name}"
            "#{@name} warps"
            "#{@name} traces a headache inducing arabesque"
        ].random()

class actor_classes.Inspiring extends Human
    name: "the microblogger"
    act: (others) ->
        other = others.random()
        return [
            "#{@name} sighs",
            "#{@name} looks optimistic",
            "#{@name} gives #{other.name} a thumbs up"
            "#{@name} shows #{other.name} a picture of a cat"
            "#{@name} writes a twitter post"
        ].random()

class actor_classes.Player extends Human
    name: "you"
    genitive: "your"
    act: (others) ->
        return [
            "#{@name} satisfy your needs"
            "#{@name} play the game"
            "#{@name} hang around"
            "#{@name} meet some people"
        ].random()

class actor_classes.Comedian extends Human
    name: "the comedian"
    act: (others) ->
        thing = (t for t in others when not t.human).random()
        other = others.random()
        return [
            "#{@name} laughs"
            "#{@name} tells #{other.name} a joke"
            "#{@name} tells a mean joke about #{other.name}"
            "#{thing.name} inspires one of #{@genitive()} jokes",
        ].random()

window.pick_actors = (actors, min, max) ->
    humans = shuffle(a for a in actors when a.human)
    things = shuffle(t for t in actors when not t.human)
    first = [things.pop(), humans.pop()]
    rest = shuffle(humans.concat(things))
    shuffled = first.concat(rest)
    n = min + Math.round(Math.random() * (max - min))
    return shuffled.slice(0, n)

capitalize = (string) ->
    return string.charAt(0).toUpperCase() + string.slice(1)

window.home_actors = () ->
    vars = state.active.variables
    friends = (new actor_classes[f.actor_class] for f in vars.friends)
    things = (new actor_classes[t.actor_class]() for t in vars.things when t.relationship > 0)
    return pick_actors(things.concat(friends).concat(new actor_classes.Player), 2, 4)

window.spin_yarn = (all_actors) ->
    acted = []
    output = []
    for i in [0..3 + Math.random() * 5]
        actors = (a for a in all_actors when not a.dead)
        havent_acted = (a for a in actors when a not in acted)
        if havent_acted.length == 0
            actor = actors.random()
        else
            actor = havent_acted.random()
            acted.push(actor)
        others = (a for a in all_actors when a != actor)
        output.push actor.act others
    string = ""

    # Names of actors
    string += capitalize((a.name for a in actors[0...-1]).join(", ")) + " and " + actors[actors.length - 1].name
    string += [
        " are spending time together."
        " are hanging out."
        " are kickin' it."
        " are playing around."
        " are having a discussion."
    ].random() + "\n"
    
    for i in [0...output.length] by 2
        if output[i+1]?
            sentence_enders = [
                '.\n'
                '!\n',
                '...\n'
            ]

            joiners = [
                ' because '
                ' and so ',
                ', therefore ',
                ' even though ',
                ' and then ',
                ' when '
                ' once '
                ' just because '
                ', and yet '
                ' but '
                ' but even still '
                " and well, let's just say "
                '. Spitefully, '
                '. Strangely, '
                '. Appropriately, '
                '. Angrily, '
                '. Passively, '
                '. Jealously, '
                '. Happily, '
                '. Fortunately, '
                ' whenever '
                ' unless ',
                ' and hell, '
                ' and just for fun '
                ' and in any case '
                ' and anyway '
            ]

            # Increase chance of sentence enders
            if Math.random() < (sentence_enders.length * 2/ (sentence_enders.length + joiners.length))
                string += capitalize(output[i]) + sentence_enders.random() + capitalize(output[i+1])
            else
                string += capitalize(output[i]) + joiners.random() + output[i+1]
            string += ".\n"
        else
            string += capitalize(output[i]) + "."
        
    return string.trim()

window.to_sentence = (ary) ->
    return ary[0...-1].join(", ") + " and " + ary[ary.length-1]
