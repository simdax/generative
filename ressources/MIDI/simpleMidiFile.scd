//MIdifile

Quarks.install("wslib");

Platform.userExtensionDir
File("/Users/zob/Music/sia-chandelier.mid")

"./".resolveRelative

a=SimpleMIDIFile.read("C:/Users/zob/Music/sia-chandelier.mid")

(
b=a.noteOnEvents.collect({ arg i; [i[4], i[1]]});
b.collect(_[0]).differentiate.drop(1)

)