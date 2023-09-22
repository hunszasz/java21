package hu.hunszasz.example;


import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class HelloJava21Test {
    @Test
    void multiline() {

        var shakespeare = """

                Lenni vagy nem lenni: az itt a kérdés.
                Akkor nemesb-e a lélek, ha tűri
                Balsorsa minden nyűgét s nyilait;
                Vagy ha kiszáll tenger fájdalma ellen,
                S fegyvert ragadva véget vet neki?
                """;
        Assertions.assertNotEquals('L', shakespeare.charAt(0));

        shakespeare = shakespeare.stripLeading();
        Assertions.assertEquals('L', shakespeare.charAt(0));
    }

    @Test
    void repeat() {
        // ①
        var line = new StringBuilder()
                .repeat("-", 10)
                .toString();
        Assertions.assertEquals("----------", line);
    }

    @Test
    void emojis() {
        // ②
        var shockedFaceEmoji = "\uD83E\uDD2F";
        var cp = Character.codePointAt(shockedFaceEmoji.toCharArray(), 0);
        Assertions.assertTrue(Character.isEmoji(cp));
        System.out.println(shockedFaceEmoji);
    }

}
