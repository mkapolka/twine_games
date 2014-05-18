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
    constructor: (pronouns) ->
        @pronouns = pronouns
    pname: () ->
        name = @name
        @pronouns.register(this, this.gender)
        return name
    gender: 'it'

window.actor_classes  = [
    class Lamp extends Actor
        off: false,
        burnt_out: false
        name: 'The table lamp'
        can_act: ->
            not @off and not @burnt_out
        act: (others) ->
            other = others.random()
            if not @off and not @burnt_out
                if Math.random() < .8
                    @name + " " + [
                        "shines light on #{other.name}",
                        "refuses to shine light on #{other.name}",
                        "blinds #{other.name}",
                        "bathes #{other.name} in bright light",
                    ].random()
                else
                    if Math.random() < .5
                        @burnt_out = true
                        return "#{@name}'s bulb burns out"
                    else
                        @off = true
                        return "#{@name} becomes unplugged"
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
                @seated = null
                return "#{@name} " + [
                    'ejects'
                ].random() + " #{other.name} onto the floor"

    class Death extends Actor
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

    class SexyFriend extends Actor
        name: "a stripper"
        human: true
        gender: 'he'
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
                'turns you on'
            ].concat(extra_actions).random()

    class Blender extends Actor
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
                "a blade breaks off of #{@name} and lodges itself inside of #{human.name}'s #{window.human_body_parts.random()}"
            ].random()

    class Toilet extends Actor
        name: "the toilet"
        act: (others) ->
            human = (x for x in others when x.human).random()
            other = others.random()
            return [
                "#{@name} slurps up #{human.name}'s shit",
                "#{@name} flushes",
                "#{@name} clogs up",
                "#{@name} makes a gurgling sound",
                "#{@name} splashes water on #{other.name}"
                "#{@name} refuses to flush"
                "#{@name} emits a disgusting smell"
                "#{@name} releases a noxious gas"
            ].random()

    class Car extends Actor
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

    class Wallpaper extends Actor
        name: "the wallpaper"
        act: (others) ->
            human = (x for x in others when x.human).random()
            other = others.random()
            return [
                "#{@name} looks like vomiting cats"
                "#{@name} peels off in flakes and lands on #{other.name}"
                "#{@name} looks like #{other.name}'s name written over and over"
                "#{@name} undulates"
                "#{@name} looks like wiry men staring at #{human.name}"
                "#{@name} surrounds #{other.name}"
                "#{@name} warps"
                "#{@name} traces a headache inducing arabesque"
            ].random()

    class Inspiring extends Actor
        name: "a microblogger"
        act: (others) ->
            other = others.random()
            return [
                "#{@name} sighs",
                "#{@name} looks optimistic",
                "#{@name} gives #{other.name} a thumbs up"
                "#{@name} shows #{other.name} a picture of a cat"
                "#{@name} writes a twitter post"
            ].random()

    class Funny extends Actor
        name: "a comedian"
        act: (others) ->
            thing = (t for t in others when not t.human).random()
            other = others.random()
            return [
                "#{@name} laughs"
                "#{@name} tells #{other.name} a joke"
                "#{@name} tells a mean joke about #{other.name}"
                "#{thing.name} inspires one of #{@name}'s jokes",
            ].random()
]

class Pronouns
    pronouns: {}
    register: (other, pronoun) ->
        if @pronouns[pronoun]? and @pronouns[pronoun]['thing'] != other
            @pronouns[pronoun]['thing'].name = @pronouns[pronoun]['old_name']

        @pronouns[pronoun] = {
            thing: other
            old_name: other.name
        }

        other.name = pronoun

window.pick_actors = (actors, min, max) ->
    humans = shuffle(a for a in actors when a.human)
    things = shuffle(t for t in actors when not t.human)
    first = [things.pop(), humans.pop()]
    rest = shuffle(humans.concat(things))
    shuffled = first.concat(rest)
    n = min + Math.round(Math.random() * (max - min))
    return shuffled.slice(0, n)

window.spin_yarn = ->
    pronouns = new Pronouns
    available_actors = (new x(pronouns) for x in window.actor_classes)
    actors = window.pick_actors(available_actors, 2, 4)
    output = []
    for i in [0..2 + Math.random() * 5]
        actors = (a for a in actors when not a.dead)
        actor = actors.random()
        others = (a for a in actors when a != actor)
        output.push actor.act others
    string = ""
    for i in [0...output.length] by 2
        if output[i+1]?
            joiners = [
                '. ',
                ' because '
                ' and so ',
                ', therefore ',
                ' even though ',
                ' and then ',
                ' when '
                ' once '
                ' just because '
            ]
            string = output[i] + joiners.random() + output[i+1]
            string += ". "
        else
            string += output[i]
        
    return string
