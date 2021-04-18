package com.nbsaas.codemake.handle.imple;

import com.nbsaas.codemake.annotation.FormField;
import com.nbsaas.codemake.annotation.InputType;
import com.nbsaas.codemake.handle.BeanHandle;
import org.apache.commons.chain.Context;

import java.lang.reflect.Field;

public class CheckComponentHandle implements BeanHandle {
    @Override
    public void handle(Class<?> object, Context context) {
        for (Class<?> clazz = object; clazz != Object.class; clazz = clazz.getSuperclass()) {
            Field[] fs = clazz.getDeclaredFields();
            for (Field f : fs) {
                FormField fieldBean=  f.getAnnotation(FormField.class);
                if (fieldBean==null){
                    continue;
                }
                if (fieldBean.type() == InputType.image) {
                    context.put("componentState", true);
                    return;
                }
                if (fieldBean.type() == InputType.el_upload) {
                    context.put("componentState", true);
                    return;
                }
                if (fieldBean.type() == InputType.richText) {
                    context.put("componentState", true);
                    return;
                }
                if (fieldBean.type() == InputType.dictionary) {
                    context.put("componentState", true);
                    return;
                }
                if (fieldBean.type() == InputType.treeView) {
                    context.put("componentState", true);
                    return;
                }
            }
        }
        context.put("componentState", false);
    }
}
