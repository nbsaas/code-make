package com.nbsaas.codemake.handle.imple;

import com.nbsaas.codemake.handle.BeanHandle;
import org.apache.commons.chain.Context;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

public abstract class BaseFieldHandle implements BeanHandle {
    @Override
    public void handle(Class<?> object, Context context) {
        List<Field> fields = new ArrayList<>();
        for (Class<?> clazz = object; clazz != Object.class; clazz = clazz.getSuperclass()) {
            Field[] fs = clazz.getDeclaredFields();
            if (fs != null) {
                for (Field f : fs) {
                    fields.add(f);
                }
            }
        }
        if (fields.size() > 0) {
            handleField(fields, context);
        }
    }

    protected abstract void handleField(List<Field> fields, Context context);
}
