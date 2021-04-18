package com.nbsaas.codemake.handle.imple;

import com.nbsaas.codemake.annotation.CreateByUser;
import com.nbsaas.codemake.handle.BeanHandle;
import org.apache.commons.chain.Context;

public class CreateByUserHandle implements BeanHandle {
    @Override
    public void handle(Class<?> object, Context context) {
        CreateByUser view = object.getAnnotation(CreateByUser.class);
        if (view == null) {
            context.put("createByUser", false);
        } else {
            context.put("createByUser", true);
        }
    }
}
