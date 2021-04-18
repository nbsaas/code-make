package com.nbsaas.codemake.handle.imple;

import com.nbsaas.codemake.annotation.FormField;
import com.nbsaas.codemake.annotation.InputType;
import com.nbsaas.codemake.handle.BeanHandle;
import org.apache.commons.chain.Context;

import java.lang.reflect.Field;
import java.util.List;

public class UeCheckHandle extends BaseFieldHandle {
    @Override
    protected void handleField(List<Field> fields, Context context) {
        for (Field field : fields) {
            FormField fieldBean= field.getAnnotation(FormField.class);
            if (fieldBean==null){
                continue;
            }
            if (fieldBean.type()== InputType.richText){
                context.put("ueConfig",true);
            }
        }
    }
}
