---
title: 一文教你实现 SpringBoot 中的自定义 Validator 和错误信息国际化配置 
layout: post
categories: 
  - 经验技巧 
tags: 
  - 经验技巧
  - Java  
---

本文通过示例说明，在 Springboot 中如何自定义 Validator，以及如何实现国际化的错误信息返回。注意，本文代码千万别直接照抄，有可能会出大事情的。先留个悬念，读者朋友们能从中看出有什么问题吗？

## 项目初始化

直接从 [springboot](https://spring.io/guides/gs/rest-service/#initial) 官网中下载模板，直接通过示例中的 `GreetingController` 添加实现逻辑。 


```java
@RestController
public class GreetingController {

	private static final String template = "Hello, %s!";
	private final AtomicLong counter = new AtomicLong();

	@RequestMapping("/greeting")
	public Response<Greeting> greeting(@RequestParam(value = "name", defaultValue = "World") String name) {
		if (!"tangleithu".equals(name)) {
			throw new BadRequestException("user.notFound");
		}
		return Response.ok(new Greeting(counter.incrementAndGet(), String.format(template, name)));
	}
```

以上代码直接源自[官方 spring-guides 的 demo](https://github.com/spring-guides/gs-rest-service.git)，我稍微改吧改吧。正常情况下，能返回正确的结果：

```json
# curl "localhost:8080/greeting?name=tangleithu&lang=en" 

{
    "code": 0,
    "data": {
        "content": "Hello, tangleithu!",
        "id": 9
    },
    "message": "success"
}
```

## 国际化需求

我们来模拟了下业务逻辑，假设输入的参数有一些校验功能，比如以上`name`参数，假设和“tangleithu”不相等，就直接返回错误。 同时希望返回的错误信息需要实现国际化，即在不同的语言环境下返回的内容不一样。 例如中文：“没找到用户呢。” 对应的英文：“User does not exist.”，而对应的德文是……，算了忽略，我也不会。

![](/resources/custom-validator-and-i18n-error-message-in-springboot/i18n-demo.png)

用一个图来表达，即希望实现的效果是，不同国家和地区的用户（不同语言）在遇到同一个业务场景下同一个错误原因，有不同的翻译。例如在参数校验没通过，Http Status Code应该返回 400，并告知错误原因；在具体的 Service 实现时可能也会遇到其他的 case 需要返回某种具体错误信息。

注意：实际业务场景中后端可能仅仅只返回错误码，具体的展示由前端根据 key 进行翻译。不过在一些更加灵活的 app 实现方案中，错误信息很有可能会由后端接口直接返回。本文只是为了做案例说明整个流程。

## 统一错误处理

借助 Spring 中的 AOP，用一个 `ControllerAdvice` 统一拦截这种`BadRequestException`异常。例如： 

```java
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(BadRequestException.class)
    @ResponseBody
    public ResponseEntity handle(HttpServletRequest request, BadRequestException e){
        String i18message = getI18nMessage(e.getKey(), request);
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response.error(e.getCode(), i18message));
    }
}
```

## 国际化配置

然后，我们在这种具体的异常信息时，用一个 key 来标记错误码，在资源文件中用不同的语言来定义应该返回的具体错误信息。例如本文示例中，添加了中英文两种。 相应的目录结构如下： 

![](/resources/custom-validator-and-i18n-error-message-in-springboot/i18n-tree.png)

此时，我们只需要在 `GlobalExceptionHandler` 中根据请求来源是中文还是英文返回对应的错误信息即可。 

```java
private String getI18nMessage(String key, HttpServletRequest request) {
   try {
       return messageSource.getMessage(key, null, LanguaggeUtils.currentLocale(request));
   } catch (Exception e) {
       // log
       return key;
   }
}
```

从请求来源获取语言信息就有多种方式啦，例如我们可以从请求头中获取 `Accept-Lanuage`（一般浏览器会根据用户的设置情况带上这个请求头的）。

![](/resources/custom-validator-and-i18n-error-message-in-springboot/i18n-header.png)

或者我们自己显示定义一些例如 lang 之类的参数。本文不做详细阐述，咱们就简单用 `lang` 这个参数来定义，如下：

```java
public class LanguaggeUtils {
    public static Locale currentLocale(HttpServletRequest request) {
        // 从 RequestHeader 等等获取相应的语言信息
        // 简单起见，直接从 queryParams 中取, 只模拟中英文
        String locale = request.getParameter("lang");
        if ("zh".equalsIgnoreCase(locale)) {
            return Locale.CHINA;
        } else {
            return Locale.ENGLISH;
        }
    }
}
```

这样，通过简单几行代码就能实现高大上的“国际化”参数返回了。 试试效果如下： 

```json
#curl "localhost:8080/greeting?name=tanglei&lang=en" 
{
    "code": 400,
    "data": null,
    "message": "User does not exist."
}

#curl "localhost:8080/greeting?name=tanglei&lang=zh" 
{
    "code": 400,
    "data": null,
    "message": "没找到用户呢。"
}
```

## Bean Validator

其实针对类似 Form 等参数校验，我们有更简单的方法。那就是借助 SpringBoot 中自带的 Validation 框架，本文用到的这个版本对应的实现是`jakarta.validation-api`。其实 Bean Validation 都有相应的标准，可能有不同的具体实现而已。对标准感兴趣的可以戳这里[JSR #380 Bean Validation 2.0](https://www.jcp.org/en/egc/view?id=380)。

回到本文的 demo 中，假设在我们业务逻辑中需要传递一个 `UserForm`，接收 `age,name,param` 三个参数。并对其中输入进行进行校验，其中，`param` 没有具体的含义，只是为了说明问题。

```
public class UserForm {
    @Min(value = 0, message = "validate.userform.age")
    @Max(value = 120, message = "validate.userform.age")
    private int age;

    @NotNull(message = "validate.userform.name.notEmpty")
    private String name;

    @CustomParam(message = "validate.userform.param.custom")
    private String param;
    ...
}

@RequestMapping("/user")
public Response<Greeting> createUser(@Valid @RequestBody UserForm userForm) {
	return Response.ok(new Greeting(counter.incrementAndGet(), String.format(template, userForm.getName())));
}
```

代码如上，上面示例只用了很简单的 `@Min, @Max, @NotNull`等约束条件，通过名字就能看出来含义。更多约束规则可以直接看对应源码 `javax.validation.constraints.xxx`，比如有常见的 `Email` 等格式校验。 

默认情况下，违反相应的约束条件后，默认的输出比较啰嗦，如下： 

```json
#curl -H "Content-Type: application/json" -d "{}" "localhost:8080/user"
{
    "error": "Bad Request",
    "errors": [
        {
            "arguments": [
                {
                    "arguments": null,
                    "code": "name",
                    "codes": [
                        "userForm.name",
                        "name"
                    ],
                    "defaultMessage": "name"
                }
            ],
            "bindingFailure": false,
            "code": "NotBlank",
            "codes": [
                "NotBlank.userForm.name",
                "NotBlank.name",
                "NotBlank.java.lang.String",
                "NotBlank"
            ],
            "defaultMessage": "must not be blank",
            "field": "name",
            "objectName": "userForm",
            "rejectedValue": null
        }
    ],
    "message": "Validation failed for object='userForm'. Error count: 1",
    "path": "/user",
    "status": 400,
    "timestamp": "2020-05-10T08:44:12.952+0000"
}
``` 

可以在上述的 `GlobalExceptionHandler` 修改默认的行为。

```java
@ExceptionHandler(BindException.class)
@ResponseBody
public ResponseEntity handle(HttpServletRequest request, BindException e){
   String key = e.getBindingResult().getAllErrors().get(0).getDefaultMessage();
   String i18message = getI18nMessage(key, request);
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response.error(400, i18message));
}

@ExceptionHandler(MethodArgumentNotValidException.class)
@ResponseBody
public ResponseEntity handle(HttpServletRequest request, MethodArgumentNotValidException e){
   String key = e.getBindingResult().getAllErrors().get(0).getDefaultMessage();
   String i18message = getI18nMessage(key, request);
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response.error(400, i18message));
}

@ExceptionHandler(ConstraintViolationException.class)
@ResponseBody
public ResponseEntity handle(HttpServletRequest request, ConstraintViolationException e){
   String key = e.getConstraintViolations().iterator().next().getMessage();
   String i18message = getI18nMessage(key, request);
   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response.error(400, i18message));
}
```

改进后, 增加自定义的 handler 后，返回简洁不少： 

```json
{
    "code": 400,
    "data": null,
    "message": "validate.userform.name.notEmpty"
}
```

再结合前面讲解的通过i18n的参数配置，又可以实现当没通过校验的时候，错误信息统一由对应的国际化资源文件进行配置了。 

## 自定义 Validator 

当内置的满足不了条件的时候，我们希望实现自定义的 Validator，例如前文中的 `CustomParam`。

我们需要一个 Annotation，方便在对应 Form 的时候引用校验，具体实现如下： 

```java
/**
 * @author tanglei
 * @date 2020/5/10
 */
@Documented
@Constraint(validatedBy = CustomValidator.class)
@Target({FIELD, METHOD, PARAMETER, ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface CustomParam {
    String message() default "name.tanglei.www.validator.CustomArray.defaultMessage";

    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default { };

    @Documented
    @Retention(RetentionPolicy.RUNTIME)
    @Target({FIELD, METHOD, PARAMETER, ANNOTATION_TYPE})
    @interface List {
        CustomParam[] value();
    }
}
```

还需要一个具体的 validator 实现类，通过上面的 `@Constraint(validatedBy = CustomValidator.class)` 关联起来。本文只是 demo，所以具体参数校验没有实际逻辑意义的，下面假设输入的参数和“tanglei”相同则校验通过，否则提示用户输入错误。

```java
public class CustomValidator implements ConstraintValidator<CustomParam, String> {
    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        if (null == s || s.isEmpty()) {
            return true;
        }
        if (s.equals("tanglei")) {
            return true;
        } else {
            error(constraintValidatorContext, "Invalid params: " + s);
            return false;
        }
    }

    @Override
    public void initialize(CustomParam constraintAnnotation) {
    }

    private static void error(ConstraintValidatorContext context, String message) {
        context.disableDefaultConstraintViolation();
        context.buildConstraintViolationWithTemplate(message).addConstraintViolation();
    }
}
```

看看效果，输入没校验通过，还提示你输入的参数 “xx” 不符合条件。

![](/resources/custom-validator-and-i18n-error-message-in-springboot/validator-bug.png)

是不是感觉很完美？

>注意：上文中有一个比较隐蔽的安全漏洞，请大家注意。
>>注意：上文中有一个比较隐蔽的安全漏洞，请大家注意。
>>>注意：上文中有一个比较隐蔽的安全漏洞，请大家注意。

重要的事情说三遍，总体来说本文思路还是值得借鉴的（对应代码见 [github](https://github.com/tl3shi/demo.git)），但一定要注意不要完全照抄，上面说的这个安全漏洞还挺严重的。给予点提示，就是在`CustomValidator` 的具体实现中，有朋友了解吗？欢迎留言讨论。我将在后面的文章中来讲述这个安全漏洞。