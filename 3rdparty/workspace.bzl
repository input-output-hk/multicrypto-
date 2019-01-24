# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output=ctx.path("jar/%s" % jar_name),
        url=ctx.attr.urls,
        sha256=ctx.attr.sha256,
        executable=False
    )
    src_name="%s-sources.jar" % ctx.name
    srcjar_attr=""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output=ctx.path("jar/%s" % src_name),
            url=ctx.attr.src_urls,
            sha256=ctx.attr.src_sha256,
            executable=False
        )
        srcjar_attr ='\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "com.beachape:enumeratum-macros_2.12:1.5.9", "lang": "scala", "sha1": "1a63056f0ba55a11c8d10150d27c247920e6c9c8", "sha256": "e7ef82aa1ab73d52cccfe78fa09d8491d021df153415cae6f5e60295a90ee187", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/beachape/enumeratum-macros_2.12/1.5.9/enumeratum-macros_2.12-1.5.9.jar", "source": {"sha1": "d4ea2d95cdbabc506913039463dfaac02bd8f866", "sha256": "8ce1a95fffb8d0a5eff3d4f30ec4cd653a4ad43ecbc28fa0caac9ab30ec47f61", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/beachape/enumeratum-macros_2.12/1.5.9/enumeratum-macros_2.12-1.5.9-sources.jar"} , "name": "com_beachape_enumeratum_macros_2_12", "actual": "@com_beachape_enumeratum_macros_2_12//jar:file", "bind": "jar/com/beachape/enumeratum_macros_2_12"},
    {"artifact": "com.beachape:enumeratum_2.12:1.5.13", "lang": "scala", "sha1": "f3cd444af103422b9baa0f81bf2f55d6e0378546", "sha256": "dbfdbacaa0a70d8080fc1ca5e2775b4be143678fa2ac47af0b6c7ac529f1d954", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/beachape/enumeratum_2.12/1.5.13/enumeratum_2.12-1.5.13.jar", "source": {"sha1": "b882b4108842e082c23d8423d599b59dbba90062", "sha256": "bc273aee4e92a72c6c6639dc6a30a632424bedf24fd8861f722ac32ca0c8aa4b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/beachape/enumeratum_2.12/1.5.13/enumeratum_2.12-1.5.13-sources.jar"} , "name": "com_beachape_enumeratum_2_12", "actual": "@com_beachape_enumeratum_2_12//jar:file", "bind": "jar/com/beachape/enumeratum_2_12"},
    {"artifact": "com.chuusai:shapeless_2.12:2.3.3", "lang": "scala", "sha1": "6041e2c4871650c556a9c6842e43c04ed462b11f", "sha256": "312e301432375132ab49592bd8d22b9cd42a338a6300c6157fb4eafd1e3d5033", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/chuusai/shapeless_2.12/2.3.3/shapeless_2.12-2.3.3.jar", "source": {"sha1": "02511271188a92962fcf31a9a217b8122f75453a", "sha256": "2d53fea1b1ab224a4a731d99245747a640deaa6ef3912c253666aa61287f3d63", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/chuusai/shapeless_2.12/2.3.3/shapeless_2.12-2.3.3-sources.jar"} , "name": "com_chuusai_shapeless_2_12", "actual": "@com_chuusai_shapeless_2_12//jar:file", "bind": "jar/com/chuusai/shapeless_2_12"},
    {"artifact": "com.github.pureconfig:pureconfig-core_2.12:0.10.1", "lang": "scala", "sha1": "94521c090df2b635469a2ca5ba2b30c9478920ea", "sha256": "b287e21e6a879b9e675a2f720b5019ca9da64e835aa282197137164622f1eb55", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig-core_2.12/0.10.1/pureconfig-core_2.12-0.10.1.jar", "source": {"sha1": "d314654d2e7b08e43503d16c715c2ae06323a995", "sha256": "93156c960a0c6bc75cc32fb86ca440cbc651e0e006b562589cd723c20dc77ea0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig-core_2.12/0.10.1/pureconfig-core_2.12-0.10.1-sources.jar"} , "name": "com_github_pureconfig_pureconfig_core_2_12", "actual": "@com_github_pureconfig_pureconfig_core_2_12//jar:file", "bind": "jar/com/github/pureconfig/pureconfig_core_2_12"},
    {"artifact": "com.github.pureconfig:pureconfig-generic_2.12:0.10.1", "lang": "scala", "sha1": "0bbbdee9f88161598660b127460a4d0b78297464", "sha256": "357f143df315d4baf5be4e32cdfcb03866042f92188bbb3b294b489014ba9f2f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig-generic_2.12/0.10.1/pureconfig-generic_2.12-0.10.1.jar", "source": {"sha1": "bb3e5fd5c390ede68159ae655c31a8366d01ca83", "sha256": "b8d779bb86eabb8e3c3c32e31cf4a13ee64c8baa92bbd2d98623770f8e8b71c1", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig-generic_2.12/0.10.1/pureconfig-generic_2.12-0.10.1-sources.jar"} , "name": "com_github_pureconfig_pureconfig_generic_2_12", "actual": "@com_github_pureconfig_pureconfig_generic_2_12//jar:file", "bind": "jar/com/github/pureconfig/pureconfig_generic_2_12"},
    {"artifact": "com.github.pureconfig:pureconfig-macros_2.12:0.10.1", "lang": "scala", "sha1": "6417dd8d75e0d5cc1b3f738938d6f0b60673dcf2", "sha256": "6ecfbb5e3c10c539d3b906bc3d8104ea847a03c6069c0b732cbcd2b0796bccfd", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig-macros_2.12/0.10.1/pureconfig-macros_2.12-0.10.1.jar", "source": {"sha1": "675937e081081aaf2285c0a5a1065590a86522d1", "sha256": "e2847441a61c9b2f6994ee23e0d9d08d7d1fe0fede1c4f6a365ba0b747d6cc31", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig-macros_2.12/0.10.1/pureconfig-macros_2.12-0.10.1-sources.jar"} , "name": "com_github_pureconfig_pureconfig_macros_2_12", "actual": "@com_github_pureconfig_pureconfig_macros_2_12//jar:file", "bind": "jar/com/github/pureconfig/pureconfig_macros_2_12"},
    {"artifact": "com.github.pureconfig:pureconfig_2.12:0.10.1", "lang": "scala", "sha1": "a03a6d959ee9d1a762c8aa68baa5c2e1671aa34a", "sha256": "cf4ba55a25a453eebff8671a7527012a5125daa902dd90cf6c8e4e2b9c108f8a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig_2.12/0.10.1/pureconfig_2.12-0.10.1.jar", "source": {"sha1": "d6e644636b4eb93daec5826e650b6c26bc7ce984", "sha256": "6f5ef5b8b1d7d4ed2286db88474872424c118ff574921531fdae128ee67d8ec9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig_2.12/0.10.1/pureconfig_2.12-0.10.1-sources.jar"} , "name": "com_github_pureconfig_pureconfig_2_12", "actual": "@com_github_pureconfig_pureconfig_2_12//jar:file", "bind": "jar/com/github/pureconfig/pureconfig_2_12"},
    {"artifact": "com.typesafe.akka:akka-actor-typed_2.12:2.5.12", "lang": "scala", "sha1": "072efe632266e9934bca5ce130b0c8d7da371b6e", "sha256": "e210cc3a98807ba4901a4c1b5e73dad356c6a9bdfcff2ce5960d970ffd35c2a5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-actor-typed_2.12/2.5.12/akka-actor-typed_2.12-2.5.12.jar", "source": {"sha1": "3b70cde20cf8adf2726af506dfdbabb4bf114aad", "sha256": "82f52b4d9786c09027db7dc54796959d40dadcb9224c325f301bdd26c3db18b8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-actor-typed_2.12/2.5.12/akka-actor-typed_2.12-2.5.12-sources.jar"} , "name": "com_typesafe_akka_akka_actor_typed_2_12", "actual": "@com_typesafe_akka_akka_actor_typed_2_12//jar:file", "bind": "jar/com/typesafe/akka/akka_actor_typed_2_12"},
    {"artifact": "com.typesafe.akka:akka-actor_2.12:2.5.12", "lang": "scala", "sha1": "c4c545cc1809a995dff5d816876571c0204a0fe9", "sha256": "5f766c5cefe013ca21e52fb17e5c0e2a693ca4e5261f575112d169540823f661", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-actor_2.12/2.5.12/akka-actor_2.12-2.5.12.jar", "source": {"sha1": "782093967008b1ec1cf26dff4934c9a9150a5ae3", "sha256": "bf445518e08a2a351705082fc0d00886c07c3293699c839897d79c19b36d9d4c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-actor_2.12/2.5.12/akka-actor_2.12-2.5.12-sources.jar"} , "name": "com_typesafe_akka_akka_actor_2_12", "actual": "@com_typesafe_akka_akka_actor_2_12//jar:file", "bind": "jar/com/typesafe/akka/akka_actor_2_12"},
    {"artifact": "com.typesafe.akka:akka-slf4j_2.12:2.5.12", "lang": "scala", "sha1": "985acf0acbf0cf6b1222754e5818709c90024857", "sha256": "d3912407e06d6d09a7eebb7b52b3909c90c16138ab3fa12d5495494ad0f42735", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-slf4j_2.12/2.5.12/akka-slf4j_2.12-2.5.12.jar", "source": {"sha1": "98ee5d99f7a405331f6884b7da160058f041f065", "sha256": "b3816d77c376a7e5588de22f54f3414474ad5cbee06918bd9340a983d2658b14", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-slf4j_2.12/2.5.12/akka-slf4j_2.12-2.5.12-sources.jar"} , "name": "com_typesafe_akka_akka_slf4j_2_12", "actual": "@com_typesafe_akka_akka_slf4j_2_12//jar:file", "bind": "jar/com/typesafe/akka/akka_slf4j_2_12"},
    {"artifact": "com.typesafe.akka:akka-testkit-typed_2.12:2.5.12", "lang": "scala", "sha1": "27c96dd32eb4aeb2e0c40afa9f71b5bbbc348d2d", "sha256": "e587601c4675741290096678396b19d4349ecd74132df32773900958c733a2a5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-testkit-typed_2.12/2.5.12/akka-testkit-typed_2.12-2.5.12.jar", "source": {"sha1": "a4f982e5d4a06a96b5fa5e5f85ae9459ac39bc30", "sha256": "6046105752f15955b487930ce13c28a9c9fa47d91e1f1a4d363f35232b7fd7d6", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-testkit-typed_2.12/2.5.12/akka-testkit-typed_2.12-2.5.12-sources.jar"} , "name": "com_typesafe_akka_akka_testkit_typed_2_12", "actual": "@com_typesafe_akka_akka_testkit_typed_2_12//jar:file", "bind": "jar/com/typesafe/akka/akka_testkit_typed_2_12"},
    {"artifact": "com.typesafe.akka:akka-testkit_2.12:2.5.12", "lang": "scala", "sha1": "b2ce3dfed156bc6bd46dac040ae1a0c39900f852", "sha256": "c36f58fe1f5fa574b9795c9457b07da068ecdf2a60b3ef85f1e6a4434cc4b26e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-testkit_2.12/2.5.12/akka-testkit_2.12-2.5.12.jar", "source": {"sha1": "9ffe2f4099e1b686e59e10073d2e5e1cb455e0cf", "sha256": "f487eba825a3316f68c609f7f1ad2f8a22beadc19893d9b97656cca89d1d2ea1", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-testkit_2.12/2.5.12/akka-testkit_2.12-2.5.12-sources.jar"} , "name": "com_typesafe_akka_akka_testkit_2_12", "actual": "@com_typesafe_akka_akka_testkit_2_12//jar:file", "bind": "jar/com/typesafe/akka/akka_testkit_2_12"},
# duplicates in com.typesafe:config fixed to 1.3.3
# - com.github.pureconfig:pureconfig-core_2.12:0.10.1 wanted version 1.3.3
# - com.typesafe.akka:akka-actor_2.12:2.5.12 wanted version 1.3.2
    {"artifact": "com.typesafe:config:1.3.3", "lang": "java", "sha1": "4b68c2d5d0403bb4015520fcfabc88d0cbc4d117", "sha256": "b5f1d6071f1548d05be82f59f9039c7d37a1787bd8e3c677e31ee275af4a4621", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/config/1.3.3/config-1.3.3.jar", "source": {"sha1": "c7af5bd41815a5edc8e7a81082e88fe18f9729e0", "sha256": "fcd7c3070417c776b313cc559665c035d74e3a2b40a89bbb0e9bff6e567c9cc8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/config/1.3.3/config-1.3.3-sources.jar"} , "name": "com_typesafe_config", "actual": "@com_typesafe_config//jar", "bind": "jar/com/typesafe/config"},
    {"artifact": "net.bytebuddy:byte-buddy-agent:1.8.15", "lang": "java", "sha1": "a2dbe3457401f65ad4022617fbb3fc0e5f427c7d", "sha256": "ca741271f1dc60557dd455f4d1f0363e8840612f6f08b5641342d84c07f14703", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/bytebuddy/byte-buddy-agent/1.8.15/byte-buddy-agent-1.8.15.jar", "source": {"sha1": "7bd145597e02bf07eea8cff4a3d8e0bdbe66d21f", "sha256": "8d42067e2111943eb8b873320a394d2ef760b88d7fc235942c01d384924d289c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/bytebuddy/byte-buddy-agent/1.8.15/byte-buddy-agent-1.8.15-sources.jar"} , "name": "net_bytebuddy_byte_buddy_agent", "actual": "@net_bytebuddy_byte_buddy_agent//jar", "bind": "jar/net/bytebuddy/byte_buddy_agent"},
    {"artifact": "net.bytebuddy:byte-buddy:1.8.15", "lang": "java", "sha1": "cb36fe3c70ead5fcd016856a7efff908402d86b8", "sha256": "af32e420b1252c1eedef6232bd46fadafc02e0c609e086efd57a64781107a039", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/bytebuddy/byte-buddy/1.8.15/byte-buddy-1.8.15.jar", "source": {"sha1": "a8f95953d78effdd8eca80e92c5b62f648b4a1f5", "sha256": "c18794f50d1dfc8fb57bfd886b566b05697da396022bcd63b5463a454d33c899", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/bytebuddy/byte-buddy/1.8.15/byte-buddy-1.8.15-sources.jar"} , "name": "net_bytebuddy_byte_buddy", "actual": "@net_bytebuddy_byte_buddy//jar", "bind": "jar/net/bytebuddy/byte_buddy"},
    {"artifact": "org.mockito:mockito-core:2.21.0", "lang": "java", "sha1": "cdd1d0d5b2edbd2a7040735ccf88318c031f458b", "sha256": "976353102556c5654361dccf6211c7a9de9942fabe94620aa5a1d68be6997b79", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/mockito/mockito-core/2.21.0/mockito-core-2.21.0.jar", "source": {"sha1": "6ce1c9a7dc4e816d309abb74f0c032bd3c9b59f6", "sha256": "955e885c048d65b5ad5dfdd36fff4aab48f7911a3627e75c3a47182d608a4a43", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/mockito/mockito-core/2.21.0/mockito-core-2.21.0-sources.jar"} , "name": "org_mockito_mockito_core", "actual": "@org_mockito_mockito_core//jar", "bind": "jar/org/mockito/mockito_core"},
    {"artifact": "org.objenesis:objenesis:2.6", "lang": "java", "sha1": "639033469776fd37c08358c6b92a4761feb2af4b", "sha256": "5e168368fbc250af3c79aa5fef0c3467a2d64e5a7bd74005f25d8399aeb0708d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/objenesis/objenesis/2.6/objenesis-2.6.jar", "source": {"sha1": "96614f514a1031296657bf0dde452dc15e42fcb8", "sha256": "52d9f4dba531677fc074eff00ea07f22a1d42e5a97cc9e8571c4cd3d459b6be0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/objenesis/objenesis/2.6/objenesis-2.6-sources.jar"} , "name": "org_objenesis_objenesis", "actual": "@org_objenesis_objenesis//jar", "bind": "jar/org/objenesis/objenesis"},
    {"artifact": "org.scala-lang.modules:scala-java8-compat_2.12:0.8.0", "lang": "scala", "sha1": "1e6f1e745bf6d3c34d1e2ab150653306069aaf34", "sha256": "d9d5dfd1bc49a8158e6e0a90b2ed08fa602984d815c00af16cec53557e83ef8e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/modules/scala-java8-compat_2.12/0.8.0/scala-java8-compat_2.12-0.8.0.jar", "source": {"sha1": "0a33ce48278b9e3bbea8aed726e3c0abad3afadd", "sha256": "c0926003987a5c21108748fda401023485085eaa9fe90a41a40bcf67596fff34", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/modules/scala-java8-compat_2.12/0.8.0/scala-java8-compat_2.12-0.8.0-sources.jar"} , "name": "org_scala_lang_modules_scala_java8_compat_2_12", "actual": "@org_scala_lang_modules_scala_java8_compat_2_12//jar:file", "bind": "jar/org/scala_lang/modules/scala_java8_compat_2_12"},
    {"artifact": "org.scala-sbt:test-interface:1.0", "lang": "java", "sha1": "0a3f14d010c4cb32071f863d97291df31603b521", "sha256": "15f70b38bb95f3002fec9aea54030f19bb4ecfbad64c67424b5e5fea09cd749e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0.jar", "source": {"sha1": "d44b23e9e3419ad0e00b91bba764a48d43075000", "sha256": "c314491c9df4f0bd9dd125ef1d51228d70bd466ee57848df1cd1b96aea18a5ad", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0-sources.jar"} , "name": "org_scala_sbt_test_interface", "actual": "@org_scala_sbt_test_interface//jar", "bind": "jar/org/scala_sbt/test_interface"},
    {"artifact": "org.scalacheck:scalacheck_2.12:1.14.0", "lang": "scala", "sha1": "8b4354c1a5e1799b4b0ab888d326e7f7fdb02d0d", "sha256": "1e6f5b292bb74b03be74195047816632b7d95e40e7f9c13d5d2c53bafeece62e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalacheck/scalacheck_2.12/1.14.0/scalacheck_2.12-1.14.0.jar", "source": {"sha1": "ee64746db17b19449fae7e4b9f9ffc8fb7e79d80", "sha256": "6d51786f6ed8241bc02ea90bdd769ef16f2cc034624e06877de1d4a735efcb7f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalacheck/scalacheck_2.12/1.14.0/scalacheck_2.12-1.14.0-sources.jar"} , "name": "org_scalacheck_scalacheck_2_12", "actual": "@org_scalacheck_scalacheck_2_12//jar:file", "bind": "jar/org/scalacheck/scalacheck_2_12"},
    {"artifact": "org.scalactic:scalactic_2.12:3.0.5", "lang": "scala", "sha1": "edec43902cdc7c753001501e0d8c2de78394fb03", "sha256": "57e25b4fd969b1758fe042595112c874dfea99dca5cc48eebe07ac38772a0c41", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalactic/scalactic_2.12/3.0.5/scalactic_2.12-3.0.5.jar", "source": {"sha1": "e02d37e95ba74c95aa9063b9114db51f2810b212", "sha256": "0455eaecaa2b8ce0be537120c2ccd407c4606cbe53e63cb6a7fc8b31b5b65461", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalactic/scalactic_2.12/3.0.5/scalactic_2.12-3.0.5-sources.jar"} , "name": "org_scalactic_scalactic_2_12", "actual": "@org_scalactic_scalactic_2_12//jar:file", "bind": "jar/org/scalactic/scalactic_2_12"},
    {"artifact": "org.scalatest:scalatest_2.12:3.0.5", "lang": "scala", "sha1": "7bb56c0f7a3c60c465e36c6b8022a95b883d7434", "sha256": "b416b5bcef6720da469a8d8a5726e457fc2d1cd5d316e1bc283aa75a2ae005e5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest_2.12/3.0.5/scalatest_2.12-3.0.5.jar", "source": {"sha1": "ec414035204524d3d4205ef572075e34a2078c78", "sha256": "22081ee83810098adc9af4d84d05dd5891d7c0e15f9095bcdaf4ac7a228b92df", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest_2.12/3.0.5/scalatest_2.12-3.0.5-sources.jar"} , "name": "org_scalatest_scalatest_2_12", "actual": "@org_scalatest_scalatest_2_12//jar:file", "bind": "jar/org/scalatest/scalatest_2_12"},
    {"artifact": "org.slf4j:slf4j-api:1.7.25", "lang": "java", "sha1": "da76ca59f6a57ee3102f8f9bd9cee742973efa8a", "sha256": "18c4a0095d5c1da6b817592e767bb23d29dd2f560ad74df75ff3961dbde25b79", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.jar", "source": {"sha1": "962153db4a9ea71b79d047dfd1b2a0d80d8f4739", "sha256": "c4bc93180a4f0aceec3b057a2514abe04a79f06c174bbed910a2afb227b79366", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25-sources.jar"} , "name": "org_slf4j_slf4j_api", "actual": "@org_slf4j_slf4j_api//jar", "bind": "jar/org/slf4j/slf4j_api"},
    {"artifact": "org.typelevel:macro-compat_2.12:1.1.1", "lang": "scala", "sha1": "ed809d26ef4237d7c079ae6cf7ebd0dfa7986adf", "sha256": "8b1514ec99ac9c7eded284367b6c9f8f17a097198a44e6f24488706d66bbd2b8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/macro-compat_2.12/1.1.1/macro-compat_2.12-1.1.1.jar", "source": {"sha1": "ade6d6ec81975cf514b0f9e2061614f2799cfe97", "sha256": "c748cbcda2e8828dd25e788617a4c559abf92960ef0f92f9f5d3ea67774c34c8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/macro-compat_2.12/1.1.1/macro-compat_2.12-1.1.1-sources.jar"} , "name": "org_typelevel_macro_compat_2_12", "actual": "@org_typelevel_macro_compat_2_12//jar:file", "bind": "jar/org/typelevel/macro_compat_2_12"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)