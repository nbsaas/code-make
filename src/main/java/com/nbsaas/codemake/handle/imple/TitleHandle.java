package com.nbsaas.codemake.handle.imple;

import com.nbsaas.codemake.handle.BeanHandle;
import com.nbsaas.codemake.annotation.FormAnnotation;
import org.apache.commons.chain.Context;

public class TitleHandle implements BeanHandle {
    @Override
    public void handle(Class<?> object, Context context) {

        FormAnnotation annotation = object.getAnnotation(FormAnnotation.class);
        if (annotation!=null){
            context.put("title",annotation.title());
            context.put("model",annotation.model());
        }
    }
}
