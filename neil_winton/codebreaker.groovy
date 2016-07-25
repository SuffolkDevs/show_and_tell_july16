import groovyx.gpars.GParsPool

class CipherNormaliser {
    private static def ALPHABET = ('A'..'Z')

    static String normalise(String input) {
        def chars = input.toLowerCase().collect()
        def mapping = [chars.toUnique(), ALPHABET].transpose().collectEntries()
        chars.collect { mapping[it] }.join()
    }
}

class MatchFinder {
    List<String> dictionary
    Closure normalise
    private String inputNormalised

    def matches(String input) {
        inputNormalised = normalise(input)
        checkForMatchOrSearchDeeper([])
    }

    private def checkForMatchOrSearchDeeper(List<String> matchedWords) {
        String joinedAndNormalised = normalise(matchedWords.join())
        if (joinedAndNormalised == inputNormalised) {
            println matchedWords.join(' ')
            return matchedWords
        } else if (inputNormalised.startsWith(joinedAndNormalised)) {
            tryWithAppendedDictionaryWords(matchedWords)
        }
    }

    private def tryWithAppendedDictionaryWords(List<String> matchedWords) {
        GParsPool.withPool {
            dictionary.collectParallel {
                List<String> nextAttempt = matchedWords + it
                checkForMatchOrSearchDeeper(nextAttempt)
            }.grep()
        }
    }
}

dictionary = ['beef', 'beer', 'bat', 'feed', 'road', 'cat', 'moon', 'bar', 'barn', 'noon', 'toot', 'on', 'o', 'a']
cipherText = 'barnoon'
//dictionary = new File(args[0]).readLines().collect { it.replaceAll(/[^a-zA-Z]/, '') }.toUnique()
//cipherText = args[1..-1].join().toLowerCase().replaceAll(/[^a-z]/, '')

// normaliseClosure = { String s -> s.toLowerCase().replaceAll(/[^a-z]/, '') }
normaliseClosure = CipherNormaliser.&normalise

finder = new MatchFinder(dictionary: dictionary, normalise: normaliseClosure)
println finder.matches(cipherText)