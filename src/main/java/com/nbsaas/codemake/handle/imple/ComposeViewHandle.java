package com.nbsaas.codemake.handle.imple;

import com.nbsaas.codemake.annotation.ComposeView;
import com.nbsaas.codemake.handle.BeanHandle;
import org.apache.commons.chain.Context;

public class ComposeViewHandle implements BeanHandle {


    @Override
    public void handle(Class<?> object, Context context) {
        ComposeView view = object.getAnnotation(ComposeView.class);
        if (view == null) {
            context.put("childView", false);
        } else {
            context.put("childView", true);
        }

    }
}
