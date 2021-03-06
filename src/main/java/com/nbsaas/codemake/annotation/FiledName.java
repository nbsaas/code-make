package com.nbsaas.codemake.annotation;

import java.lang.annotation.*;

@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface FiledName {

    String name() default "";

    String classType() default "String";

}
