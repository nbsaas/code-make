package com.nbsaas.codemake.handle.imple;

import com.nbsaas.codemake.annotation.FormField;
import com.nbsaas.codemake.annotation.InputType;
import org.apache.commons.chain.Context;

import java.lang.reflect.Field;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class CollectComponentHandle extends BaseFieldHandle {
    
    @Override
    protected void handleField(List<Field> fields, Context context) {
        
        Set<String> sets=new HashSet<>();
        for (Field field : fields) {
            FormField fieldBean= field.getAnnotation(FormField.class);
            if (fieldBean==null){
                continue;
            }
            if (fieldBean.type()== InputType.image){
                sets.add("avatar");
            }
            if (fieldBean.type()== InputType.el_upload){
                sets.add("avatar");
            }
            if (fieldBean.type()== InputType.dictionary){
                sets.add("nbSelect");
            }
        }
        context.put("components",sets);

    }
}
