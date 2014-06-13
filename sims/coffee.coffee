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
        other = others.random()
        actions = [
            "#{@name} shines light on #{other.name}",
            "#{@name} refuses to shine light on #{other.name}",
            "#{@name} blinds #{other.name}",
            "#{@name} bathes #{other.name} in bright light",
            "#{@name} burns #{other.name}"
            "#{@name} dimly illuminates #{other.name}"
            "#{@name} provides sexy mood lighting"
        ]
        if not knows_thing('toilet') and Math.random() < .3
            actions.push("#{@name} shines light on a pamphlet for [[toilets|MeetToilet]]")
        return actions.random()

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
            "a blade breaks off of #{@name} and lodges itself inside of #{human.genitive()} #{window.human_body_parts.random()}"
        ].random()

class actor_classes.Toilet extends Thing
    name: "the toilet"
    act: (others) ->
        human = (x for x in others when x.human).random()
        other = others.random()
        return [
            "#{@name} slurps up #{human.genitive()} shit",
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
        other = others.random()
        human = (o for o in others when o.human).random()
        actions = [
            "#{@name} looks like vomiting cats"
            "#{@name} peels off in flakes and lands on #{other.name}"
            "#{@name} undulates"
            "#{@name} surrounds #{other.name}"
            "#{@name} warps"
            "#{@name} speaks volumes about your character"
            "#{@name} reveals your innermost desires"
            "the red color of the wallpaper makes you feel angry"
            "the yellow color of the wallpaper makes you feel happy"
            "the blue color of the wallpaper makes you feel sad"
            "the orange color of the wallpaper makes you feel optimistic"
        ]

        return actions.random()

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
    genitive: () -> "your"
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

class actor_classes.Dancer extends Human
    name: "the dancer"
    act: (others) ->
        return [
            "#{@name} twirls on her foot"
        ].random()

class actor_classes.Priest extends Human
    name: "the priest"
    act: (others) ->
        return [
            "#{@name} prays"
        ].random()

class actor_classes.Clown extends Human
    name: "the clown"
    act: (others) ->
        other = others.random()
        return [
            "#{@name} throws a pie at #{other.name}"
        ].random()

class actor_classes.Fascist extends Human
    name: "the fascist"
    act: (others) ->
        other = others.random()
        return [
            "#{@name} oppresses #{other.name}"
        ].random()

class actor_classes.Enduring extends Human
    name: "the endurer"
    act: (others) ->
        other = others.random()
        return [
            "#{@name} endures"
        ].random()


class actor_classes.Jissom extends Thing
    name: "the puddle of ejaculate"
    act: (others) ->
        other = others.random()
        return [
            "#{@name} dries up a little."
            "#{@name} slips #{other.name}"
            "#{@name} gets on #{other.name}"
            "#{@name} smells funky"
            "#{@name} gets on the curtains"
            "#{@name} gets on the walls"
            "#{@name} gives #{other.name} a little taste"
        ].random()

window.pick_actors = (actors, min, max) ->
    humans = shuffle(a for a in actors when a.human)
    things = shuffle(t for t in actors when not t.human)
    first = [things.pop(), humans.pop()]
    rest = shuffle(humans.concat(things))
    shuffled = first.concat(rest)
    n = min + Math.round(Math.random() * (max - min))
    return shuffled.slice(0, n)

window.pick_some = (array, min, max) ->
    a = shuffle(array.slice(0))
    n = Math.ceil(Math.random() * (min + (max - min)))
    return a.slice(0, n)

capitalize = (string) ->
    return string.charAt(0).toUpperCase() + string.slice(1)

window.main_story = () ->
    friendly_things = (t for t in state.active.variables.things when t.relationship > 0)
    things = pick_some(friendly_things, 1, 2)
    friends = pick_some(state.active.variables.friends, 1, 2)
    all = things.concat(friends)
    actors = (new actor_classes[a.actor_class] for a in all).concat(new actor_classes.Player())
    yarn = spin_yarn(actors)
    bonuses = []
    for thing in things
        if Math.random() < .2
            add_relationship(thing_by_id(thing['id']), 1)
            bonuses.push("Your relationship level with #{thing.name} has increased to \"#{get_relationship_name(thing['relationship'])}\"")

    # Portraits
    portraits = ""
    for friend in friends
        portraits += "<<Portrait #{friend.portrait}>>"

    yarn = portraits + "\n\n" + yarn

    if bonuses.length > 0
        return yarn + "\n\n" + bonuses.join("\n")
    return yarn

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
        s = actor.act others
        output.push s
        console.log(actors, actor, s)
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
                '. Awkwardly, '
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
