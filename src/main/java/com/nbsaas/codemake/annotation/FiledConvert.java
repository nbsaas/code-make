package com.nbsaas.codemake.annotation;

import java.lang.annotation.*;

@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface FiledConvert {

    String classType() default "Long";

    String dao() default "";

}
