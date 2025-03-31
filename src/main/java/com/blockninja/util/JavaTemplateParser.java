package com.blockninja.util;

import com.blockninja.ValkyrienPlugin;
import freemarker.template.Template;
import net.mcreator.generator.template.InlineTemplatesHandler;
import net.mcreator.java.CodeCleanup;
import net.mcreator.plugin.PluginLoader;
import net.mcreator.ui.MCreator;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.util.Map;

public class JavaTemplateParser {
    public static final String TEMPLATES_DIR = "templates/java/";
    private static final Logger LOG = LogManager.getLogger(ValkyrienPlugin.LOG_NAME);

    /**
     * Gets the string contents of a file, located in
     * <code>{@literal <plugin root>/templates/java/<path>.java.ftl}</code>
     * @param path the filename to look for
     * @return The {@link String} contents of the file, or <code>""</code> if an error occured
     */
    public static String getTemplateString(String path) {
        String full_path = TEMPLATES_DIR + path + ".java.ftl";
        InputStream stream = PluginLoader.INSTANCE.getResourceAsStream(full_path);
        try {
            return new String(stream.readAllBytes(), StandardCharsets.UTF_8);
        } catch (IOException e) {
            LOG.warn("Failed to read file at: {}", full_path);
            LOG.error("Error: {}", e.getMessage());
            return "";
        }
    }

    /**
     * Uses ftl on <code>text</code> to replace all keys from the <code>mcreator</code> data provider.
     * For example, if the text contains <code>Hello ${JavaModName}!</code> it will end up as something like
     * <code>Hello MyMcreatorMod!</code>.
     * @param mcreator Used to get the {@link net.mcreator.generator.template.base.BaseDataModelProvider BaseDataModelProvider} of the current workspace
     * @param text The text to replace keys in
     * @return The text with replaced keys, or the text with no replaced keys if an error occurred
     */
    public static String parseFtl(MCreator mcreator, String text) {
        try {
            Template freemarkerTemplate = InlineTemplatesHandler.getTemplate(text);
            Map<String, Object> dataModel = mcreator.getWorkspace().getGenerator().getBaseDataModelProvider().provide();
            StringWriter stringWriter = new StringWriter();
            freemarkerTemplate.process(dataModel, stringWriter, InlineTemplatesHandler.getConfiguration().getObjectWrapper());
            return stringWriter.getBuffer().toString();
        } catch (Exception e) {
            LOG.warn("Failed to parse FTL file: {}...", text.substring(0, 20));
            LOG.error("Error: {}", e.getMessage());
            return text;
        }
    }

    /**
     * Uses MCreators {@link CodeCleanup} class to format the <code>text</code>.
     * E.g. automatically adding imports, formatting newlines, etc.
     * @param mcreator
     * @param text The Java text String to format. Unexpected results may occur if the string is not written as Java
     * @return The formatted text
     */
    public static String formatJava(MCreator mcreator, String text) {
        return new CodeCleanup().reformatTheCodeAndOrganiseImports(mcreator.getWorkspace(), text);
    }

    /**
     * Simply calls {@link #getTemplateString(String)} {@link #parseFtl(MCreator, String)} and {@link #formatJava(MCreator, String)} sequentially
     * @param mcreator
     * @param path
     * @return
     */
    public static String fullyParseTemplate(MCreator mcreator, String path) {
        String template = getTemplateString(path);
        String parsedTemplate = parseFtl(mcreator, template);
        return formatJava(mcreator, parsedTemplate);
    }

}
