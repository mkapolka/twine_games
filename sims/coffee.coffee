################################################################################
window.human_body_parts = [
    'nose', 'eyes', 'forehead', 'scalp', 'left ear', 'right ear', 'cheek',
    'lips', 'tongue', 'chin', 'neck', "adam's apple", 'throat', 'shoulder blade',
    'shoulder', 'funny bone', 'forearm', 'elbow', 'wrist', 'left hand', 'right hand',
    'index finger', 'thumb', 'middle finger', 'ring finger', 'pinky', 'fingernail',
    'palm', 'heart', 'chest', 'ribs', 'stomach', 'kidney', 'lungs', 'belly button', 'hips',
    'genitals', 'taint', 'butt', 'thigh', 'knee', 'ankle', 'shin', 'heel', 'foot', 'big toe',
    'pinky toe'
]

window.foods = [
    'milk', 'lettuce', 'cabbage', 'pork', 'beef', 'chicken', 'quinoa', 'beets',
    'potatoes', 'carrots', 'peaches', 'oranges', 'apples'
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

#********************************************************************************
# THING CLASSES
#********************************************************************************

class actor_classes.Lamp extends Thing
    off: false,
    burnt_out: false
    name: 'the table lamp'
    can_act: ->
        not @off and not @burnt_out
    tv_prompted: false
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
        #if not knows_thing('tv') and Math.random() < .7 and not @tv_prompted
        if not knows_thing('tv') and not @tv_prompted
            @tv_prompted = true
            return "[[a light shines from someone who isn't the lamp|MeetTV]]"
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
        if Math.random() < .25
            return @seat_act(others)
        else
            other = others.random()
            human = (o for o in others when o.human).random()
            return [
                "#{@name} cushions #{other.name}",
                "#{@name} supports #{other.name}",
                "#{@name} comforts #{other.name}",
                "#{@name} relaxes #{other.name}",
                "#{@name} eases #{human.genitive()} weary #{human_body_parts.random()}",
                "#{@genitive()} leather glistens in the sun",
            ].random()
    seat_act: (others) ->
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

class actor_classes.Blender extends Thing
    name: "the blender"
    act: (others) ->
        human = (x for x in others when x.human).random()
        other = others.random()
        if not knows_thing('refrigerator') and not @fridge_prompted and Math.random() < .5
            @fridge_prompted = true
            return "[[you make a smoothie but you have nowhere to put it|FridgeMeet]]"

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
        if not knows_thing('shower') and not @shower_prompted and Math.random() < .5
            @shower_prompted = true
            return "[[you notice the toilet's sibling|ShowerMeet]]"
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
            "the orange color of the wallpaper makes you feel optimistic",
            "#{@name} undulates",
            "#{@name} wiggles",
            "#{@name} bursts",
            "#{@name} distends",
        ]

        return actions.random()

class actor_classes.Fridge extends Thing
    name: "the refrigerator"
    prompted_party: false
    act: (others) ->
        other = others.random()
        human = (o for o in others when o.human).random()
        actions = [
            "#{@name} cools #{other.name}",
            "#{@name} feeds #{other.name} #{window.foods.random()}",
            "#{@name} blows cold air at #{other.name}",
            "#{@name} traps #{other.name} within itself",
            "#{@name} spoils the #{window.foods.random()}"
            "#{human.name} eats some #{window.foods.random()} from #{@name}",
            "#{@genitive()} food goes into #{human.genitive()} mouth",
        ]
        if state.active.variables.tupperware_partied
            actions = actions.concat([
                "#{human.name} eats some leftover mashed potatoes from your mother"
            ])
        if not state.active.variables.tupperware_partied and Math.random() < .5 and not @prompted_party
            return "[[#{@name} is almost out of food!|TupperwareParty]]"
            @prompted_party = true
        return actions.random()

tv_shows = [
    "a doctor show", "a cop show", "a comedy", "a reality show", "a drama",
    "a mystery show"
]

products = [
    "deodorant", "cologne", "shampoo", "watches", "cars", "music", "diapers",
    "car insurance", "booze"
]

class actor_classes.Television extends Thing
    name: "the T.V."
    reduced_hp: false
    act: (others) ->
        if thing_by_id("tv").hp > 0
            return @act_alive(others)
        else
            return @act_dead(others)
    act_alive: (others) ->
        if not @reduced_health
            thing_by_id("tv").hp -= 1
            @reduced_health = true

        other = others.random()
        human = (o for o in others when o.human).random()
        actions = [
            "#{@name} puts on #{tv_shows.random()}",
            "#{@name} tells #{other.name} to buy #{products.random()}"
        ]
        return actions.random()
    act_dead: (others) ->
        return "[[#{@name} does nothing|BuryTV]]"

class actor_classes.Shower extends Thing
    name: "the shower"
    act: (others) ->
        other = others.random()
        human = (o for o in others when o.human).random()
        actions = [
            "#{@name} cleans #{other.name}",
            "#{@name} soaks #{other.name}",
            "#{@name} douses #{other.name} with cold water",
            "#{@name} douses #{other.name} with hot water",
            "#{other.name} gets in the shower",
            "#{human.name} pees in the shower",
            "#{human.name} cleans their #{human_body_parts.random()}",
            "#{human.name} cleans behind their ears",
        ]
        return actions.random()

#********************************************************************************
# FRIEND CLASSES
#********************************************************************************

class actor_classes.Stripper extends Human
    name: "the gigolo"
    act: (others) ->
        other = others.random()
        human = (x for x in others when x.human).random()
        if not human
            human = new actor_classes.Player()
        return [
            "#{@name} turns #{human.name} on",
            "#{@name} gives #{human.name} a lap dance",
            "#{@name} fucks #{other.name}",
            "#{@name} blows kisses at #{other.name}"
            "#{@name} winks at #{other.name}"
            "#{@name} offers #{other.name} his services"
            "#{@name} looks sexy",
            "#{@name} struts his stuff",
        ].random()

class actor_classes.Inspiring extends Human
    name: "the microblogger"
    act: (others) ->
        other = others.random()
        return [
            "#{@name} sighs",
            "#{@name} looks optimistic",
            "#{@name} gives #{other.name} a thumbs up"
            "#{@name} shows #{other.name} a funny picture"
            "#{@name} writes a twitter post"
            "#{@name} writes a thinkpiece about #{other.name}"
            "#{@name} liveblogs"
            "#{@name} tweets about #{other.name}"
            "#{@name} makes a passive aggresive post about #{other.name}"
            "#{@name} starts a petition"
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
        human = (t for  t in others when t.human).random() or new actor_classes.Player()
        other = others.random()
        actions = [
            "#{@name} laughs"
            "#{@name} tells #{other.name} a joke"
            "#{@name} tells a mean joke about #{other.name}"
            "#{@name} makes fun of #{other.name}",
            "#{@name} makes fun of #{human.genitive()} #{human_body_parts.random()}",
            "#{other.name} inspires one of #{@genitive()} jokes",
            "#{@name} roasts #{other.name}",
            "#{@name} ribs #{other.name}",
            "#{@name} jibes #{other.name}",
        ].random()

class actor_classes.Dancer extends Human
    name: "the dancer"
    act: (others) ->
        human = (h for h in others when h.human).random() or new actor_classes.Player()
        other = others.random()
        return [
            "#{@name} twirls on her foot",
            "#{@name} does a saucy jig",
            "#{@name} bends in surprising ways",
            "#{human.name} spins and dips #{@name}",
            "#{@name} grinds on #{other.name}",
            "#{@name} twerks towards #{other.name}",
            "#{@name} thrusts her hips towards #{other.name}",
            "#{@genitive()} hips lie",
            "#{@name} shakes what her mother gave her",
            "#{@name} shakes her money maker"
        ].random()

class actor_classes.Priest extends Human
    name: "the priest"
    act: (others) ->
        other = others.random()
        return [
            "#{@name} prays for peace",
            "#{@name} prays for #{other.name}",
            "#{@name} believes in #{other.name}",
            "#{@name} gives a sermon",
            "#{@name} debates #{other.name}",
            "#{@name} weeps for #{other.genitive()} soul",
            "#{@name} fears hell",
            "#{@name} persuades #{other.name} to fear God",
        ].random()

class actor_classes.Clown extends Human
    name: "the clown"
    act: (others) ->
        other = others.random()
        human = (h for h in other when h.human).random() or new actor_classes.Player()
        return [
            "#{@name} throws a pie at #{other.name}"
            "#{@name} clowns around with #{other.name}",
            "#{@name} honks a horn at #{other.name}",
            "#{@name} bumbles",
            "#{@name} steps on #{human.genitive()} feet",
            "#{@name} plays with a rubber chicken",
            "#{@name} grins at #{other.name}",
            "#{@name} cries at #{other.name}",
            "#{@name} points and laughs at #{other.name}",
            "#{@name} rides a little tricycle around the house",
        ].random()

class actor_classes.Fascist extends Human
    name: "the fascist"
    act: (others) ->
        other = others.random()
        return [
            "#{@name} oppresses #{other.name}"
            "#{@name} demands #{other.name} respect him"
            "#{@name} invents a salute"
            "#{@name} salutes #{other.name}"
            "#{@name} commits war crimes"
            "#{@name} convinces #{other.name} of his greatness"
            "#{other.name} respects #{@name}"
            "#{other.name} follows #{@name}"
            "#{other.name} joins #{@genitive()} regime"
        ].random()

class actor_classes.Enduring extends Human
    name: "the endurer"
    act: (others) ->
        other = others.random()
        return [
            "#{@name} endures",
            "#{@name} inspires #{other.name}",
            "#{@name} is an example for us all",
            "#{@name} never complains",
            "#{@name} forgives #{other.name}",
            "#{@name} tells a story about her hardships",
            "#{@name} tells #{other.name} a story about her hardships",
            "#{@name} reminds #{other.name} to be thankful for what they have",
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
            "#{@name} gives #{other.name} a little taste",
            "#{@name} wafts smells at #{other.name}",
            "#{@name} coagulates"
        ].random()

window.pick_some = (array, min, max) ->
    a = shuffle(array.slice(0))
    n = min + Math.ceil(Math.random() * (max - min))
    n = min if n == 0
    return a.slice(0, n)

capitalize = (string) ->
    return string.charAt(0).toUpperCase() + string.slice(1)
window.capitalize = capitalize

window.main_story = () ->
    friendly_things = (t for t in state.active.variables.things when t.can_adventure_with)
    things = pick_some(friendly_things, 1, 2)
    friends = pick_some(state.active.variables.friends, 1, 2)

    # Check for guaranteed actor classes
    guaranteed_thing = state.active.variables.guaranteed_thing
    if guaranteed_thing and guaranteed_thing.id not in (t.id for t in things)
        things[0] = guaranteed_thing
        state.active.variables.guaranteed_thing = null
    guaranteed_friend = state.active.variables.guaranteed_friend
    if guaranteed_friend and guaranteed_friend.id not in (f.id for f in friends)
        friends[0] = guaranteed_friend
        state.active.variables.guaranteed_friend = null

    actors = (new actor_classes[a.actor_class] for a in things.concat(friends))
    player = new actor_classes.Player()
    # Add the player if there aren't enough people
    if friends.length == 1 and Math.random() < .5 or friends.length == 0
        actors = actors.concat(player)
    
    return spin_yarn(actors)

window.spin_yarn = (all_actors) ->
    acted = []
    output = []
    for i in [0..2 + Math.random() * 2]
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
    string = ""

    # Names of actors
    # string += capitalize((a.name for a in actors[0...-1]).join(", ")) + " and " + actors[actors.length - 1].name
    # string += [
        # " are spending time together."
        # " are hanging out."
        # " are kickin' it."
        # " are playing around."
        # " are having a discussion."
    # ].random() + "\n"
    
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
                '. Awkwardly, ',
                '. Coyly, ',
                ' whenever '
                ' unless ',
                ' and hell, '
                ' and just for fun '
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
