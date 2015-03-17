package org.apache.kylin.streaming.Nous;

import java.io.IOException;

import org.apache.kylin.common.util.JsonUtil;
import org.junit.Ignore;
import org.junit.Test;

/**
 * Created by Hongbin Ma(Binmahone) on 3/16/15.
 */
public class NousMessageTest {
    @Test
    public void testJson() throws IOException {
        NousMessage a = new NousMessage(1, 2, "a", "b", "c", "d", "e", 100, 200.0, 300);
        String x = JsonUtil.writeValueAsIndentString(a);
        NousMessage b = JsonUtil.readValue(x, NousMessage.class);
        System.out.print(b.getClick());
    }

    @Ignore("disable this producer since it will make number of messages in a topic agnostic ")
    @Test
    public void testProducer() throws IOException, InterruptedException {
        NousEternalStreamProducer p = new NousEternalStreamProducer(10);
        p.start();
        Thread.sleep(5000);
        p.stop();
    }
}
