package com.nbsaas.codemake.handle.imple;

import com.nbsaas.codemake.handle.BeanHandle;
import org.apache.commons.chain.Context;

import java.lang.reflect.Field;

public class StoreStateHandle implements BeanHandle {
    @Override
    public void handle(Class<?> object, Context context) {
        for (Class<?> clazz = object; clazz != Object.class; clazz = clazz.getSuperclass()) {
            Field[] fs = clazz.getDeclaredFields();
            for (Field f : fs) {
//                if (f.getType() == StoreState.class) {
//                    context.put("storeState", true);
//                    return;
//                }
            }
        }
        context.put("storeState", false);

    }
}
