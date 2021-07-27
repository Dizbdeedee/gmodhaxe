import gmod.helpers.sent.SentBuild;

class ExampleEntity extends gmod.helpers.sent.SentBuild<gmod.sent.ENT_ANIM> {

    final properties:EntFields = {
        Base : "base_entity"
    }

    override function Initialize() {
        trace("Example entity spawned");
    }
    
}