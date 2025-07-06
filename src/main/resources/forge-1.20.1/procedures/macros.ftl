<#macro withSupplier returnType body preBody=''>

new Object() {
    ${preBody}
    ${returnType} get() {
        ${body}
    }
}.get()

</#macro>

<#macro returnServerLevel nullValue value>
(
    (world instanceof ServerLevel sl) ?
        ${value} :
        ${nullValue}
)
</#macro>

<#macro ifServerLevel body>
{
    if (world instanceof ServerLevel sl) {
        ${body}
    }
}
</#macro>
